Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "visitors#index"
  resources :users, only: %i(show)

  resources :timesheets, only: %i(new index create destroy show)
  resources :tickets, only: %i(create update destroy)

end
