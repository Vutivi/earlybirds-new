class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :set_raven_context
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :cellphone, :identity_number, :licence_number, :gender])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :cellphone, :identity_number, :licence_number, :gender])
    end

    def track_action action, visitable
      unless current_user.eql?(visitable.user)
        ahoy.track action, visitable_id: visitable.id, visitable_type: visitable.class.name
      end
    end

  private
  
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    def set_raven_context
      Raven.user_context(id: session[:current_user_id]) # or anything else in session
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
end
