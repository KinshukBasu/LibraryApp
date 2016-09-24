Rails.application.routes.draw do

  get 'welcome/index'

  get '/bookings/search', :controller => 'bookings', :action => 'search'


  resources :bookings do
    get :search, :on => :member, :as => :search
  end

  resources :rooms
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

end
