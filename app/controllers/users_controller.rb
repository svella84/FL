class UsersController < Devise::RegistrationsController
  before_action :only_signed_in_user, only: [:show, :add_credit, :update_credit]

  def show
  end

  def add_credit
  	@info = current_user.information
  end

  def update_credit
  	@info = current_user.information
    if @info.add_credit(params[:information][:credit])
      flash[:success] = "Credito aggiunto correttamente!"
      redirect_to profile_path
    else
      flash.now[:error] = "Importo non corretto!"
      render :action => 'add_credit'
    end
  end

  def delete_account
    unless current_user.campaigns && current_user.offers
      current_user.destroy
      flash[:success] = "Eliminazione avvenuta con successo"
      redirect_to root_path
    else
      flash[:error] = "Impossibile eliminare l'account, contattare gli amministratori."
      redirect_to profile_path
    end
  end

  private

  def sign_up_params
  	params.require(:user).permit(:email, :password, :password_confirmation, :information_attributes => [:name, :surname])
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :information_attributes => [:name, :surname, :date_of_birth, :address, :city, :country, :post_code, :phone, :image_url])
  end

  def after_update_path_for(resource)
    profile_path
  end

end
