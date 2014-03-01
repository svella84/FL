class AdminsController < ApplicationController
  before_action :only_admin

  def managment
    @products = Product.all.order("created_at DESC").paginate(page: params[:page], per_page: 15)
    @users = User.all.paginate(page: params[:page], per_page: 15)
    @orders = Order.all.paginate(page: params[:page], per_page: 15)


    if params[:search]
      @products = Product.all.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 15)
    end

    if params[:UserId]
      @users = User.find(UserId)
    end

    if params[:OrderId]
      @orders = Order.User.find(OrderId)
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
