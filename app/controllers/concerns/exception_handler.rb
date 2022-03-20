# frozen_string_literal: true

# concern for handling exceptions
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_error_exception
    rescue_from ActiveRecord::RecordInvalid, with: :rescue_error_exception
    rescue_from ActiveRecord::RecordNotDestroyed, with: :rescue_error_exception
    rescue_from ActiveRecord::StatementInvalid, with: :rescue_error_exception
    rescue_from NoMethodError, with: :rescue_error_exception
    rescue_from ValidateParams::ValidateParamsMissingError, with: :rescue_error_exception
    rescue_from ValidateParams::ValidateParamsError, with: :rescue_error_exception
  end

  def rescue_error_exception(error)
    message = if error.respond_to?(:receiver) && error.receiver.key?(:object)
                error.receiver[:object].errors.full_messages.to_sentence
              else
                error.message
              end

    render_error(message, :unprocessable_entity)
  end

  private

  def render_error(message, status)
    render json: { status: 'error', error: message }, status: status
  end
end
