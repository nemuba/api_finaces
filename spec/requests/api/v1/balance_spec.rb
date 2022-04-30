require 'rails_helper'

RSpec.describe 'Api::V1::Balances', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }
  let(:balance) { create(:balance) }
  let(:headers) { { 'Authorization' => "Bearer #{token.first}" } }

  describe 'GET /api/v1/balances' do
    it 'with response success' do
      get '/api/v1/balances', headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/balances/:id' do
    it 'with response success' do
      get "/api/v1/balances/#{balance.id}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /api/v1/balances' do
    it 'with response success' do
      params = { balance_value: 200 }
      post '/api/v1/balances', params: params, headers: headers
      expect(response).to have_http_status(:success)
    end

    it 'validate only number positive' do
      params = { balance_value: -200 }
      post '/api/v1/balances', params: params, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'validate number must be present' do
      params = { balance_value: nil }
      post '/api/v1/balances', params: params, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT /api/v1/balances/:id' do
    it 'with response success' do
      params = { balance_value: 200 }
      put "/api/v1/balances/#{balance.id}", params: params, headers: headers
      expect(response).to have_http_status(:success)
    end

    it 'validate only number positive' do
      params = { balance_value: -1  }
      put "/api/v1/balances/#{balance.id}", params: params, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'validate number must be present' do
      params = { balance_value: nil }
      put "/api/v1/balances/#{balance.id}", params: params, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /api/v1/balances/:id' do
    it 'with response success' do
      delete "/api/v1/balances/#{balance.id}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
