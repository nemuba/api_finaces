require 'rails_helper'

RSpec.describe 'Api::V1::Registration', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }

  describe 'POST api/v1/users/sign_up' do
    it 'response with success' do
      post '/api/v1/users/sign_up', params: attributes_for(:user)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE api/v1/users/delete' do
    it 'response with success' do
      delete '/api/v1/users/delete', headers: { 'Authorization' => "Bearer #{token.first}" }
      expect(response).to have_http_status(:success)
    end
  end
end
