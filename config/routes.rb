Rails.application.routes.draw do

  get 'sign_up/new'

  get 'sign_up/create'

  get 'welcome/display'
  get '/signup', to: 'sign_up#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#signon', as: 'logout', :what => 'logout'
  get 'bookings/booking_history', to: 'bookings#booking_history', as: 'bookingHistory'
  get 'bookings/room_history', to: 'bookings#room_history', as: 'roomHistory'
  post '/sessions', to: 'sessions#signon', as: 'signon'
  post '/sign_up/create', to: 'sign_up#create', as: 'sign_up_create_post'

  get '/users/edit/:id', to: 'users#edit', as: 'user_edit'

  get '/rooms/edit/:id', to: 'rooms#edit', as: 'room_edit'

  get '/bookings/search', :controller => 'bookings', :action => 'search'

  post '/search/user', to: 'users#user_search', as: 'user_search'

  get '/user/information', to: 'users#user_information', as: 'user_information'

  post '/user/change_role', to: 'users#change_user_role', as: 'user_change_role'

  post '/user/delete', to: 'users#delete_user', as: 'delete_user'

  get '/rooms/index', to: 'rooms#index'


  get '/bookings/search_static', :controller => 'bookings', :action => 'search_static', as:'static_search'

  post '/bookings', to: 'bookings#create', as: 'create_bookings'

  get '/bookings/bookingMailer/:id', to: 'bookings#bookingMailer', as: 'booking_mailer'

  post '/bookings/sendMail', to: 'bookings#send_mail', as:'booking_send_mail'

  post '/users/update', to: 'users#update', as: 'user_update_post'

  resources :bookings do
    get :search, :on => :member, :as => :search
  end

  resources :rooms
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#display'
end
