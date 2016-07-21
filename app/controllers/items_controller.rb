class ItemsController < ApplicationController

  # Devise Authentification
  skip_before_action :authenticate_user!
  before_action :check_auth

  # Sends Unauthorized Users to the Landing Page
  def check_auth
    unless user_signed_in?
      redirect_to :controller => :landing_page
    end
  end

  # "Index" View
  def index
    @items = current_user.items
  end

  # New Item Path
  def new
    @item = Item.new
  end

  # Redirects "Show" View to the "Index" View
  def show
    @item = Item.find(params[:id])
    redirect_to :action => 'index'
  end

  # Edit Item Path
  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  # Edit Item Path
  def edit
    @item = Item.find(params[:id])
  end

  # New Item Path
  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  # Destroy Item Path
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to :action => 'index'
  end

  # Parameters of an Item per the Migration
  private

  def item_params
    params.require(:item).permit(:name, :retailer, :description, :url, :price)
  end
end
