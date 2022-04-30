module Api
  module V1
    class ApiController < ApplicationController
      include ExceptionHandler
      include ValidateParams
      include Response
    end
  end
end
