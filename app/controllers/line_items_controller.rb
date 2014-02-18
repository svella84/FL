class LineItemsController < ApplicationController

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id, params[:line_items][:qnt])

    if @line_item.respond_to?(:save)
      @line_item.save
      flash[:success] = 'Prodotto Aggiunto con successo.'
      redirect_to @line_item.cart
    else
      flash[:alert] = @line_item
      redirect_to product
    end
  end
end
