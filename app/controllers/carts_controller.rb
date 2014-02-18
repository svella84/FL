class CartsController < ApplicationController

  def show
    begin
      @cart = Cart.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      flash[:alert] = 'Invalid cart'
      redirect_to root_path
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @cart }
      end
    end
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    flash[:success] = 'Your cart is currently empty'
    redirect_to root_path
  end

end
