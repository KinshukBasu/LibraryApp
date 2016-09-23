Rails.application.routes.draw do




  get 'welcome/display'

  resources :rooms
  get '/signup', to: 'user#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#signon', as: 'logout', :what => 'logout'
  get 'bookings/booking_history', to: 'bookings#booking_history', as: 'bookingHistory'

  post '/sessions', to: 'sessions#signon', as: 'signon'
  root 'welcome#display'
  resources :users

  resources :sessions, only: [:new, :signon, :destroy]

 resource :bookings





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
