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
    order = current_user.orders.build(order_params)
    order.expense = current_cart.total_price
    order.status_id = 1
    
    credit = current_user.information.credit - order.expense

    if order.check_sum(current_user.information.credit)
      if order.save && current_user.information.update(:credit => credit) && current_cart.destroy
        flash[:success] = "Ordine eseguito con successo"
        redirect_to root_path
      else
        render "new"
      end
    else
      flash[:alert] = "Non puoi procedere con l'acquisto credito insufficente'"
      redirect_to add_credit_path
    end
   

  end

  private

    def order_params
      params.require(:order).permit(:name, :surname, :city, :country, :andress, :post_code)
    end

end
