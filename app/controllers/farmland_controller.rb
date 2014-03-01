class FarmlandController < ApplicationController

  def index
    @products = Product.where(active:true).last(6).reverse
    @pushs = Product.where(active:true, push:true).last(4).reverse
  end

end
