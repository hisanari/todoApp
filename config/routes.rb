Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }
  resource :users, only: [:show]
  root 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/help',    to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
end
