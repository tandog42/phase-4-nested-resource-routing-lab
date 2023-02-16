class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found



  def index
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

def show 
items = Item.find(params[:id])
render json: items, status: :not_found
end

def create
  user = find_user
  item = user.items.create(item_params)
  render json: item, status: :created
end




  private

  def find_item
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def item_params
params.permit(:name, :description, :price)
  end

def render_not_found(e)
  render json: { errors: "404" }, status: :not_found
end

end
