Rails.application.routes.draw do
  root 'static#home'
  
  devise_for :users, :controllers => { registrations: 'registrations'}
  devise_scope :user do
    get '/sign_up' => 'registrations#new'
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end

  resources :charities
  resources :charges, only: [:new, :create, :destroy]

end
