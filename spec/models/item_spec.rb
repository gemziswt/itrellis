require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
  	it "is valid with valid attributes"do
  		expect(Item.new(:title => "test",:description=>"test", :duedate=>Date.today)).to be_valid
  	end

  	it "is not valid with a title longer than 150 chracters"do
  		expect(Item.new(:title => "test"*100, :duedate => Date.today)).to_not be_valid
  	end

  	it "is not valid with a duedate in the past" do
  		expect(Item.new(:title => "test", :duedate => 2.days.ago )).to_not be_valid
  	end

  	it "is valid with an empty description" do
  		expect(Item.new(:title => "test",:description => nil, :duedate => Date.today)).to be_valid
  	end
  	
  	it "is not valid without a title" do
  		expect(Item.new(:title => nil, :duedate => Date.today)).to_not be_valid
  	end

  end

  describe "completed" do

  	it "is complete" do
  		item = Item.new(:title => "test", :duedate => Date.today,:completed => Date.yesterday)
  		expect(item.completed?).to be_truthy
  	end

  	it "is not complete" do
  		item = Item.new(:title => "test", :duedate => Date.today,:completed => nil)
  		expect(item.completed?).to be_falsey
  	end
  end

  describe "overdue" do
  	it "is overdue" do
  		item = Item.new(:title => "test", :duedate => 2.days.ago,:completed => nil)
  		expect(item.overdue?).to be_truthy
  	end

  	it "is not overdue" do
  		item = Item.new(:title => "test", :duedate => Date.tomorrow,:completed => nil)
  		expect(item.overdue?).to be_falsey
  	end
  end

  end
