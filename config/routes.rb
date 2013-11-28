Gwc::Application.routes.draw do
  devise_for :users 
  
  mount RailsAdmin::Engine => '/teacher', :as => 'rails_admin'
  
  root 'static_page#home'

  resources :meetings
  resources :projects, only: [:show]
  resources :users, only: [:show, :edit, :update]
  resources :completed_projects, only: [:new, :create]

	get 'user_root' => 'users#show'

  get 'contact' => 'static_page#contact'
  get 'conduct' => 'static_page#conduct'
  get 'home'		=> 'static_page#home'

end
