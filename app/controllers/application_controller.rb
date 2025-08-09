class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    # サインアップ時にnicknameを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    # アカウント編集時にもnicknameを許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end
end
