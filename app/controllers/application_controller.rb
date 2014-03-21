class ApplicationController < ActionController::Base
  include ApplicationHelper
  include FarmlandHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    
  def current_cart # CREAZIONE O APERTURA CARELLO DELLA SESSIONE
    Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
  helper_method :current_cart

end
