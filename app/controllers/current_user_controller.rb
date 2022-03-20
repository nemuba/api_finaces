class CurrentUserController < ApplicationController
  before_action :authenticate_and_set_user

  def index
    render json: UserSerializer.new(current_user)
  end
end
