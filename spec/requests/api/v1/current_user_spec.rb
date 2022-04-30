require 'rails_helper'

RSpec.describe "Api::V1::CurrentUsers", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }

  describe 'GET api/v1/current_user' do
    it 'returns http success' do
      get '/api/v1/current_user', headers: { 'Authorization' => "Bearer #{token.first}" }
      expect(response).to have_http_status(:success)
    end
  end
end
