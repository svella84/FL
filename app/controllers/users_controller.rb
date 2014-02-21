class UsersController < Devise::RegistrationsController
  before_action :only_signed_in_user, only: [:show, :add_credit, :update_credit, :wishlist]

  def show
  end

  def credit
    @info = current_user.information
  end

  def add_credit
    @info = current_user.information
    if @info.add_credit(params[:information][:credit])
      flash[:success] = "Credito aggiunto correttamente!"
      redirect_to profile_path
    else
      flash.now[:alert] = "Importo non corretto!"
      render :action => 'add_credit'
    end
  end

  def wishlist
    @wishs = Wishlist.where(user_id: current_user.id).paginate(page: params[:page], per_page: 5)
  end

  def add_wishlist
    unless Wishlist.where(user_id: current_user.id, product_id: params[:product_id])
      wish_item = Wishlist.new(user_id: current_user.id, product_id: params[:product_id])
      wish_item.save
      flash[:success] = "Prodotto inserito correttamente nella tua lista dei Desideri"
      redirect_to root_path
    else
      flash[:alert] = "Prodotto gia' presente nella tua lista dei Desideri"
      redirect_to root_path
    end
  end

  def delete_account
    current_user.destroy
    flash[:success] = "Eliminazione avvenuta con successo"
    redirect_to root_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :information_attributes => [:name, :surname])
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :information_attributes => [:name, :surname, :date_of_birth, :andress, :city, :country, :post_code, :phone, :image_url])
  end

  def after_update_path_for(resource)
    profile_path
  end

end
