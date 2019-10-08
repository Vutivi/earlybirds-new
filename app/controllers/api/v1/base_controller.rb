class Api::V1::BaseController <  ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  before_action :authenticate_user!
  respond_to :json

  # before_action :configure_permitted_parameters, if: :devise_controller?

  # # This allow to add extra permitted attributes for devise registration and account update
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, {
  #     keys: [
  #       :civility, :first_name, :last_name, :birth_date, :optin_newsletters, :optin_partners_newsletters
  #     ]
  #   })
  #   devise_parameter_sanitizer.permit(:account_update, {
  #     keys: [
  #       :civility, :first_name, :last_name, :birth_date, :optin_newsletters, :optin_partners_newsletters
  #     ]
  #   })
  # end

  rescue_from StandardError,                with: :internal_server_error

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def user_not_authorized(exception)
    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def internal_server_error(exception)
    if Rails.env.development?
      response = { type: exception.class.to_s, message: exception.message, backtrace: exception.backtrace }
    else
      response = { error: "Internal Server Error" }
    end
    render json: response, status: :internal_server_error
  end
end