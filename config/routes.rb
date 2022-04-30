Rails.application.routes.draw do
  # routes API::V1
  namespace :api do
    namespace :v1 do
      resources :balances
      get 'current_user', to: 'current_user#index'

      api_guard_scope 'users' do
        # registration
        post 'users/sign_up' => 'users/registration#create'
        delete 'users/delete' => 'users/registration#destroy'

        # authentication
        post 'users/sign_in' => 'users/authentication#create'
        delete 'users/sign_out' => 'users/authentication#destroy'

        # password
        patch 'users/passwords' => 'users/passwords#update'

        # refresh token
        post 'users/tokens' => 'users/tokens#create'
      end
    end
  end
end
