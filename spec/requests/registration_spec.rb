require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }

  describe 'POST /users/sign_up' do
    it 'response with success' do
      post '/users/sign_up', params: attributes_for(:user)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /users/delete' do
    it 'response with success' do
      delete '/users/delete', headers: { 'Authorization' => "Bearer #{token.first}" }
      expect(response).to have_http_status(:success)
    end
  end
end
