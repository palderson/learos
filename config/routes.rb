Learos::Application.routes.draw do
  resources :projects do
    get 'change_name', to: 'projects#change_name'
    put 'comments', to: 'projects#comments'
    get 'archive', to: 'projects#archive'
    resources :collaborations
  end

  resources :jira_sessions
  get 'jira_authorize', to: 'jira_sessions#authorize'

  resources :archives do
    get 'unarchive', to: 'archives#unarchive'
  end

  mount StripeEvent::Engine => '/stripe'
  get "content/gold"
  get "content/silver"
  get "content/platinum"
  authenticated :user do
    root :to => 'home#index'
    # get 'user', to: 'users#show'
  end

  root :to => "home#index"
  get 'landing', to: 'home#landing'

  devise_for :users
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'subscriptions#update_card'
  end
  resources :users do
    resources :subscriptions
  end

  namespace :integrations, path: 'integration' do
    resources :jira do
      put 'verify', to: 'jira#verify'
    end
  end
end
