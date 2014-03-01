class OrdersController < ApplicationController
  before_action :only_signed_in_user

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to root_path, :notice => "Your cart is empty"
      return
    end

    @order = Order.new

  end

  def create
    @order = current_user.orders.build(order_params)
    @order.expense = current_cart.total_price
        
    credit = current_user.information.credit - @order.expense

    if @order.check_sum(current_user.information.credit)
      if @order.save
        current_user.information.update(:credit => credit)

	current_cart.line_items.each do |line_item|
	  product = Product.find(line_item.product_id)
	  qnt = product.qnt - line_item.qnt
	  product.update(:qnt => qnt)
        end

        @order.add_line_items_from_cart(current_cart)

        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        flash[:success] = "Ordine eseguito con successo"
        redirect_to orders_path
      else
        render "new"
      end
    else
      flash[:alert] = "Non puoi procedere con l'acquisto credito insufficente"
      redirect_to add_credit_path
    end
  end

  def index 
    @orders = current_user.orders.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def show
    @order = Order.find(params[:id])
    @line_items = @order.line_items
  end

  private

    def order_params
      params.require(:order).permit(:name, :surname, :city, :country, :andress, :post_code)
    end

end
