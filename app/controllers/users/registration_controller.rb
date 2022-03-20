# frozen_string_literal: true

# module Users
module Users
  # == Users::RegistrationController
  class RegistrationController < ApiGuard::RegistrationController
    include ExceptionHandler
    include ValidateParams
    
    before_action :authenticate_resource, only: [:destroy]
    before_action -> { validate_params(:name, :email, :password, :password_confirmation, presence: true) }, only: [:create]

    def create
      init_resource(sign_up_params)
      if resource.save
        create_token_and_set_header(resource, resource_name)
        render_success(message: I18n.t('api_guard.registration.signed_up'))
      else
        render_error(422, object: resource)
      end
    end

    def destroy
      current_resource.destroy
      render_success(message: I18n.t('api_guard.registration.account_deleted'))
    end

    private

    def sign_up_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
  end
end
