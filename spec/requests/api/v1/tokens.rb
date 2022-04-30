require 'rails_helper'

RSpec.describe 'Api::V1::Tokens', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }

  describe 'POST api/v1/users/tokens' do
    it 'response with success' do
      post '/api/v1/users/tokens', headers: { 'Authorization' => "Bearer #{token.first}", 'Refresh-Token': token.last }

      expect(response).to have_http_status(:success)
    end
  end
end
