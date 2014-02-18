module FarmlandHelper

  private

    def only_signed_in_user
    	unless current_user
    	  flash[:allert] = 'Devi essere loggato per avere accesso a tale funzione'
    	  redirect_to new_session_path(resource_name)
    	end
    end

end
