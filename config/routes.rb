Learos::Application.routes.draw do
  resources :projects do
    get 'change_name', to: 'projects#change_name'
    put 'comments', to: 'projects#comments'
    resources :collaborations
  end

  mount StripeEvent::Engine => '/stripe'
  get "content/gold"
  get "content/silver"
  get "content/platinum"
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'subscriptions#update_card'
  end
  resources :users do
    resources :subscriptions
  end
end
