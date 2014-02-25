class FarmlandController < ApplicationController
  before_action :only_admin, only: [:managment]

  def index
    @products = Product.where(active:true).order("created_at DESC").last(6)
    @pushs = Product.where(active:true, push:true).order("created_at DESC").last(4)
  end

  def managment
    @products = Product.all.paginate(page: params[:page], per_page: 15)
    @users = User.all.paginate(page: params[:page], per_page: 15)
    @orders = Order.all.paginate(page: params[:page], per_page: 15)
  end

end
