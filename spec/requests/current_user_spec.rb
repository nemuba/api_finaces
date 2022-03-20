require 'rails_helper'

RSpec.describe "CurrentUsers", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }

  describe 'GET /index' do
    it 'returns http success' do
      get '/current_user', headers: { 'Authorization' => "Bearer #{token.first}" }
      expect(response).to have_http_status(:success)
    end
  end
end
