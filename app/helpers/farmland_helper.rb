module FarmlandHelper

  private

    def verify_admin #CONTROLLER PRODUCTS
      authenticate_user!

      if current_user.admin
        return
      else
        flash[:alert] = "Permesso negato"
        redirect_to root_path
      end
    end

    def only_signed_in_user #CONTROLLER USERS, ORDERS
      authenticate_user!
    end

    def verify_order #CONTROLLER ORDERS
      if Order.where(id: params[:id]).empty?
        if current_user.admin
          flash[:alert] = "Ordine Non Esiste"
          redirect_to root_path
        else
          flash[:alert] = "Permesso negato"
          redirect_to root_path
        end
      else
        @order = Order.find(params[:id])
        if current_user.admin || (current_user.id == @order.user_id)
          return
        else
          flash[:alert] = "Permesso negato"
          redirect_to root_path
        end
      end
    end

    def verify_cart #CONTROLLER CARTS
      if Cart.where(id: params[:id]).empty?
        return
      else
        @cart = Cart.find(params[:id])
        if current_cart == @cart
          return
        else
          flash[:alert] = "Permesso negato"
          redirect_to root_path
        end
      end
    end

    def current_user? #VIEW USER-SHOW
      current_user.id == @user.id
    end

end
