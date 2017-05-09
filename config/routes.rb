Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'

    resources :projects, only: %i[new create destroy]
  end

  devise_for :users
  root 'projects#index'

  resources :projects, only: %i[index show edit update] do
    resources :tickets
  end
end
