# frozen_string_literal: true

# class CurrentUser
class CurrentUserController < ApplicationController
  before_action :authenticate_and_set_user

  def index
    render_json UserSerializer.new(current_user)
  end
end
