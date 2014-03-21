class AdminsController < ApplicationController
  before_action :verify_admin
  before_action :verify_user, only: [:show]

  def managment
    @products = Product.last(20)
    @orders = Order.last(20)
    @users = User.where(admin: false).order("last_sign_in_at ASC").last(20)
    @usersA = User.where(admin: true).order("last_sign_in_at ASC").last(6)
  end

  def products
    if params[:qnt] || params[:active] || params[:push]
      if params[:qnt]
        @products = Product.where("qnt < ?", params[:qnt])
      elsif params[:active]
        @products = Product.where(active: params[:active])
      else
        @products = Product.where(push: params[:push])
      end
    else
      @products = Product.all
    end
  end

  def users
    if params[:user_active] || params[:admin]
      if params[:admin]
        @users = User.where(admin: params[:admin])
      elsif params[:user_active]
        if params[:user_active] == "5"
          @users = User.where(failed_attempts: params[:user_active].to_i)
        else
          @users = User.where(locked_at: nil)
        end
      end
    else
      @users = User.all
    end
  end

  def orders
    if  params[:order_status]
      @orders = Order.where(status_id: params[:order_status])
    else
      @orders = Order.all
    end
  end

  def show # VIEW PROFILO UTENTE
    @user = User.find(params[:id])
    render "users/show"
  end

  def mod_user_admin # MODIFICA USER/ADMIN ADMIN/USER
    user = User.find(params[:id])
    user.update(:admin => !user.admin) 
    redirect_to managment_path
  end

  def mod_user_lock # MODIFICA LOCK/UNLOCK UNLOCK/LOCK
    user = User.find(params[:id])
    if user.locked_at == nil
      user.update(:failed_attempts => 5)
      user.update(:locked_at => Time.now.utc)
    else
      user.update(:failed_attempts => 0)
      user.update(:locked_at => nil) 
    end
    redirect_to managment_path   
  end

  def next_status # AVANZA STATO NELLA SPEDIZIONE
    order = Order.find(params[:id])
    status = order.status_id + 1
    order.update(:status_id => status) 
    redirect_to managment_path
  end

end
