module FarmlandHelper

  private

    def only_signed_in_user
    	unless current_user
    	  flash[:allert] = 'Devi essere loggato per avere accesso a tale funzione'
    	  redirect_to root_path
    	end
    end

end
