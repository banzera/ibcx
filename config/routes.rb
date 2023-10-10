Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :accounts do
    member do
      post :update_all
    end
  end

  resources :policies, only: [:index, :show] do

    resources :repayment_requests, path: 'rr' do
    end

    member do
      get :fetch
      get :history
    end
  end

  get :detail, to: "dashboard#detail"

  # Defines the root path route ("/")
  root "dashboard#home"

end
