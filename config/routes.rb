Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/help',    to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  devise_for :users, controllers: { registrations: :registrations }

  resource :users, only: %i[show]

  resources :task_lists, only: %i[create destroy] do
    resources :todos, only: %i[index create destroy]
  end

  namespace :todos do
    resources :status, only: %i[update]
  end

  resources :all_todos, only: %i[index]
  resources :before_work_todos, only: %i[index]
  resources :done_all_todos, only: %i[index]
  resources :expired_all_todos, only: %i[index]
end
