Rails.application.routes.draw do
  root "pages#show", page: "home"

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :bands do
    resources :setlists, only: [:new, :create]
  end

  resources :setlists
end
