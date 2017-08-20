require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

 let(:valid_attributes){
 	{"title"=>"test", "description"=>"test", "duedate"=>Date.tomorrow}
 }

 let(:invalid_attributes){
 	{"title"=>"nil","description"=>"","duedate"=>Date.yesterday}
 }

 let(:update_attributes){
 	{"title" => "new", "completed" => Date.today}
 }
 let(:invalid_update_attributes){
 	{"title" => nil, "completed" => Date.today}
 }


 describe "GET index" do
   it "assigns all items as @items" do 
   	item = Item.create valid_attributes
   	get :index
   	expect(assigns(:items)).to eq([item])
   end

   it "renders the index template" do
   	item = Item.create valid_attributes
   	get :index
   	expect(response).to render_template("index")
   end

end
 describe "GET show" do
    it "assigns the requested item as @item" do
    	item = Item.create valid_attributes
    	get :show, params: {id:item.id}
    	expect(assigns(:item)).to eq(item)
    end
end
  describe "GET new" do
    it "assigns a new item as Item and renders new template" do 
    	get :new
    	expect(assigns[:item]).to be_a(Item)
    	expect(response).to render_template :new
    end
end
 describe "POST create" do

    context "with valid params" do
      it "creates a new Widget" do 
      	expect{
      		post :create, params: {:item => valid_attributes}
      	}.to change(Item,:count).by(1)
      end

      it "redirects to the created item" do
      	post :create, params: {:item => valid_attributes}
      	expect(response).to redirect_to(Item.last)
      	end
     end

    context "with invalid params"
      it "does not save the new item" do 
      	expect{
      		post :create, params: {:item => invalid_attributes}
      	}.to_not change(Item,:count)
      end
     it " re-renders the 'new' template" do
     	post :create, params: {:item => invalid_attributes}
     	expect(response).to render_template :new
     end
 end

 describe "PUT update" do
 	
    context "with valid params" do
      it 'assigns the requested item ' do
      	item = Item.create valid_attributes
      	put :update, params:{id:item.id, :item => update_attributes}
      	expect(assigns(:item)).to eq(item)
      end
      it "updates the requested item and redirects to  updated contact" do
      	item = Item.create valid_attributes
      	put :update, params:{id:item.id, :item => update_attributes}
      	item.reload
      	expect(item.title).to eql("new")
      	expect(response).to redirect_to(item)
      end

     end
    context "with invalid params" do
      it "assigns the item" do 
      	item = Item.create valid_attributes
      	put :update, params:{id:item.id, :item => invalid_update_attributes}
      	expect(assigns(:item)).to eq(item)
      end
      it "re-renders the 'edit' template" do
      	item = Item.create valid_attributes
      	put :update, params:{id:item.id, :item => invalid_update_attributes}
      	expect(response).to render_template :edit
  	  end
     end
 end
 describe "DELETE destroy" do
    it "destroys the requested widget" do
    	item = Item.create valid_attributes
    	expect{
      		delete :destroy, params: {:id => item.id}
      	}.to change(Item,:count).by(-1)

    end
    it "redirects to the items list" do 
    	item = Item.create valid_attributes
    	delete :destroy, params: {:id => item.id}
    	expect(response).to redirect_to(items_url)
    end
 end
 
 describe "completed" do
 it "updates completed and redirects to items list" do 
 	item = Item.create valid_attributes
 	patch :complete, params: {:id => item.id}
 	item.reload
 	expect(item.completed).to be_truthy
 	expect(response).to redirect_to(items_url)
 end
end
end