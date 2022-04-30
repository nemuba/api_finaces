# frozen_string_literal: true

# module Api
module Api
  # module V1
  module V1
    # class Api::V1::CurrentUser
    class CurrentUserController < ApiController
      before_action :authenticate_and_set_user

      def index
        render_json(UserSerializer.new(current_user))
      end
    end
  end
end
