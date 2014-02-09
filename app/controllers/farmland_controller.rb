class FarmlandController < ApplicationController
  def index
    @products = Product.last(6)
    @pushs = Product.where(push:true).last(4)
  end
end
