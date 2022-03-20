# frozen_string_literal: true

# class ApplicationController
class ApplicationController < ActionController::API
  include ExceptionHandler
  include ValidateParams
end
