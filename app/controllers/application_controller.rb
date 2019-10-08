class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :cellphone])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :cellphone])
    end

    def track_action action, visitable
      unless current_user.eql?(visitable.user)
        ahoy.track action, visitable_id: visitable.id, visitable_type: visitable.class.name
      end
    end
end
