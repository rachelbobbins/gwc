Gwc::Application.routes.draw do
  devise_for :users 
  
  mount RailsAdmin::Engine => '/teacher', :as => 'rails_admin'
  
  root 'static_page#home'

  resources :meetings do
    resource :attendance, only: [:edit, :update]
  end
  resources :projects, only: [:show]
  resources :users, only: [:show, :edit, :update]
  resources :completed_projects, only: [:new, :create]
  # resources :attendances, only: [:index]

  get 'attendance'  => 'attendances#index'
	get 'user_root'   => 'users#show'
  get 'contact'     => 'static_page#contact'
  get 'conduct'     => 'static_page#conduct'
  get 'home'		    => 'static_page#home'
  get 'email_list'  => 'static_page#email_list'

end
