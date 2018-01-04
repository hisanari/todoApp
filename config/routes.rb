Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/help',    to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  devise_for :users, controllers: { registrations: :registrations }
  resource :users,      only: %i[show]
  resource :task_lists, only: %i[new create destroy]
end
