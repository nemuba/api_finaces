# frozen_string_literal: true

# module ValidateParams
module ValidateParams
  extend ActiveSupport::Concern

  def validate_params(*keys, presence: true)
    raise ValidateParamsError, 'Parâmetros de validação não informados' unless keys.present?
    raise ValidateParamsError, 'Método de validação de parâmetros não definido: presence: true' if presence.nil?

    keys.each do |key|
      !param_present?(key) && raise(ValidateParamsMissingError, "Parâmetro obrigatório: :#{key}")
    end
  end

  def param_present?(key)
    params[key].present?
  end

  class ValidateParamsError < StandardError; end

  class ValidateParamsMissingError < StandardError; end
end
