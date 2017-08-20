class Item < ApplicationRecord

	validates :title, length: {maximum: 150}, presence: true
	validates :description, length:{maximum: 1000}, allow_blank: true
	
	validates_each :duedate do |record,attr,value|
		record.errors.add(attr,"must be in the future") if value < (Date.today)
	end

	def overdue?
		!completed && duedate < Date.today
	end
end
