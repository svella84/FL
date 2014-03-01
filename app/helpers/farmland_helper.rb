module FarmlandHelper

  private

    def only_signed_in_user
    	unless current_user
    	  flash[:allert] = 'Devi essere loggato per avere accesso a tale funzione'
    	  redirect_to new_session_path(resource_name)
    	end
    end

    def only_admin
      unless current_user.admin?
        flash[:allert] = "Permesso negato"
	redirect_to root_path
      end
    end

    def current_user?
      current_user.id == @user.id
    end

end
