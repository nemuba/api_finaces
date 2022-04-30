require 'rails_helper'

RSpec.describe 'Api::V1::Passwords', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }

  describe 'POST api/v1/users/passwords' do
    it 'response with success' do
      patch '/api/v1/users/passwords', headers: { 'Authorization' => "Bearer #{token.first}" }, params: { password: '123456789', password_confirmation: '123456789' }

      expect(response).to have_http_status(:success)
    end
  end
end
