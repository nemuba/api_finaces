# frozen_string_literal: true

# == Response
module Response
  extend ActiveSupport::Concern

  def render_json(object, status: :ok, **options)
    options[:status] = status

    render json: object, **options
  end
end
