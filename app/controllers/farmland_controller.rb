class FarmlandController < ApplicationController
  before_action :only_admin, only: [:managment]

  def index
    @products = Product.last(6)
    @pushs = Product.where(push:true).last(4)
  end

  def managment
    @products = Product.all
    @users = User.all
    @orders = Order.all
  end

end
