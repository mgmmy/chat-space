Rails.application.routes.draw do
  require 'sidekiq/web'

  ChatSpace::Application.routes.draw do
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web, at: "/sidekiq"
    end
  end

  get 'admin_users/index'

  devise_for :users
  root "groups#index"
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
  end
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
  end
end
