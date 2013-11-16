Gwc::Application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/teacher', :as => 'rails_admin'
  
  root 'meetings#index'

  resources :posts
  resources :meetings

  get 'contact' => 'static_page#contact'
  get 'conduct' => 'static_page#conduct'

end
