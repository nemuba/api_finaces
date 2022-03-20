Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'current_user', to: 'current_user#index'
  api_guard_routes for: 'users', except: [:registration]

  api_guard_scope 'users' do
    post 'users/sign_up' => 'users/registration#create'
    delete 'users/delete' => 'users/registration#destroy'
  end
end
