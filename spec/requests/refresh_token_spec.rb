require 'rails_helper'

RSpec.describe 'Refresh Token', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }

  describe 'POST /users/tokens' do
    it 'response with success' do
      post '/users/tokens', headers: { 'Authorization' => "Bearer #{token.first}", 'Refresh-Token': token.last }

      expect(response).to have_http_status(:success)
    end
  end
end
