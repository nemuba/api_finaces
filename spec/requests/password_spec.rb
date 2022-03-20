require 'rails_helper'

RSpec.describe 'Password', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }

  describe 'POST /users/passwords' do
    it 'response with success' do
      patch '/users/passwords', headers: { 'Authorization' => "Bearer #{token.first}" }, params: { password: '123456789', password_confirmation: '123456789' }

      expect(response).to have_http_status(:success)
    end
  end
end
