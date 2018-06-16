Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/help',    to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  devise_for :users, controllers: { registrations: :registrations }

  resource :users, only: %i[show]

  scope 'user' do
    resources :task_lists, only: %i[create edit update destroy] do
      resources :todos, only: %i[index create edit update destroy]
      resources :status, only: %i[update], module: 'todos'
    end

    scope module: :todos do
      resources :all_todos, only: %i[index]
      resources :before_work_todos, only: %i[index]
      resources :done_all_todos, only: %i[index]
      resources :expired_all_todos, only: %i[index]
    end

    resources :search_pages, only: %i[index]

  end
end
