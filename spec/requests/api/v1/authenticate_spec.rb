require 'rails_helper'

RSpec.describe 'Api::V1::Authentication', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }

  describe 'Post api/v1/users/sign_in' do
    it 'response with success' do
      post '/api/v1/users/sign_in', params: { email: user.email, password: user.password }

      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE api/v1/users/sign_out' do
    it 'response with success' do
      delete '/api/v1/users/sign_out', headers: { 'Authorization' => "Bearer #{token.first}" }

      expect(response).to have_http_status(:success)
    end
  end
end
