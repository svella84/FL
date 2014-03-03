class AdminsController < ApplicationController
  before_action :verify_admin

  def managment

    #MAGAZINO
    if params[:search] || params[:qnt] || params[:active] || params[:push]
      if params[:search]
        @products = Product.all.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 15)
      elsif params[:qnt]
        @products = Product.where("qnt < ?", params[:qnt]).order("created_at DESC").paginate(page: params[:page], per_page: 15)
      elsif params[:active]
        @products = Product.where(active: params[:active]).order("created_at DESC").paginate(page: params[:page], per_page: 15)
      else
        @products = Product.where(push: params[:push]).order("created_at DESC").paginate(page: params[:page], per_page: 15)
      end
    else
      @products = Product.all.order("created_at DESC").paginate(page: params[:page], per_page: 15)  
    end

    #USERS
    if params[:UserId] || params[:user_active] || params[:admin]
      if params[:UserId]
        @users = User.where(id: params[:UserId]).paginate(page: params[:page], per_page: 15)
      elsif params[:admin]
        @users = User.where(admin: params[:admin]).paginate(page: params[:page], per_page: 15)
      elsif params[:user_active]
        if params[:user_active] == "5"
          @users = User.where(failed_attempts: params[:user_active].to_i).paginate(page: params[:page], per_page: 15)
        else
          @users = User.where(locked_at: nil).paginate(page: params[:page], per_page: 15)
        end
      end
    else
      @users = User.all.paginate(page: params[:page], per_page: 15)  
    end

    #ORDERS
    if params[:OrderId] || params[:Order_UId] || params[:order_status]
      if params[:OrderId]
        @orders = Order.where(id: params[:OrderId]).paginate(page: params[:page], per_page: 15)
      elsif params[:Order_UId]
        @orders = Order.where(user_id: params[:Order_UId]).paginate(page: params[:page], per_page: 15)
      else
        @orders = Order.where(status_id: params[:order_status]).paginate(page: params[:page], per_page: 15)
      end
    else
      @orders = Order.all.order("created_at DESC").paginate(page: params[:page], per_page: 15)
    end
  end

  def show
    @user = User.find(params[:id])
    render "users/show"
  end

  def mod_user_admin
    user = User.find(params[:id])
    user.update(:admin => !user.admin) 
    redirect_to managment_path
  end

  def mod_user_lock
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

  def next_status
    order = Order.find(params[:id])
    status = order.status_id + 1
    order.update(:status_id => status) 
    redirect_to managment_path
  end

end
