# frozen_string_literal: true

# concern for handling exceptions
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :rescue_error_exception
    rescue_from ActiveRecord::RecordNotDestroyed, with: :rescue_error_exception
    rescue_from ActiveRecord::StatementInvalid, with: :rescue_error_exception
    rescue_from NoMethodError, with: :rescue_error_exception
    rescue_from ValidateParams::ValidateParamsMissingError, with: :rescue_error_exception
    rescue_from ValidateParams::ValidateParamsError, with: :rescue_error_exception
  end

  def rescue_error_exception(error)
    render_error(error.message, :unprocessable_entity)
  end

  def record_not_found(error)
    render_error(I18n.t('active_record.errors.messages.record_not_found', record: error.model, id: error.id), :not_found)
  end

  private

  def render_error(message, status)
    render json: { status: 'error', error: message }, status: status
  end
end
