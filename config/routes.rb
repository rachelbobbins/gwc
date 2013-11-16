Gwc::Application.routes.draw do
  
  root 'posts#index'

  resources :posts
  resources :meetings

  get 'contact' => 'static_page#contact'

end
