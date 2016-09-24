Rails.application.routes.draw do

  get 'sign_up/new'

  get 'sign_up/create'

  get 'welcome/display'
  get '/signup', to: 'sign_up#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#signon', as: 'logout', :what => 'logout'
  get 'bookings/booking_history', to: 'bookings#booking_history', as: 'bookingHistory'
  post '/sessions', to: 'sessions#signon', as: 'signon'
  post '/sign_up/create', to: 'sign_up#create', as: 'sign_up_create_post'

  resources :bookings
  resources :rooms
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#display'
end
