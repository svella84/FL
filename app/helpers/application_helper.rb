module ApplicationHelper
  private

    def session_user
      @user = User.new
    end
  
    def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

    def resource_class
      devise_mapping.to
    end
end
