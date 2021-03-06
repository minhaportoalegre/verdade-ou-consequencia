CariocaPergunta::Application.routes.draw do
  match '/auth/:provider/callback',   :to => 'sessions#create'

  post '/candidates/check', to: 'candidates#check', as: :candidates_check


  resources :likes, only: [:create, :update]

  resources :candidates do
    resources :answers, except: [:destroy] 
    put :finish
  end

  resources :unions, :parties, only: [:index, :show] do 
    resources :candidates, only: [:index, :show]
  end

  resources :questions do
    resources :votes, :only => :create
  end

  resources :users, only: [:index, :new, :create, :update] do
    resources :answers, except: [:index, :new, :destroy]
    resources :parties, :unions, only: [:index] do
      resources :candidates
    end
  end

  resources :subscribers
  
  resources :sessions,    only: [:destroy, :new]
  
  get 'auth/meurio',      as: :meurio_auth
  get 'auth/facebook',    as: :facebook_auth
  get 'home', :to => "candidates#home", :as => :candidates_home

  resources :answers, except: [:destroy]
  root :to => "sessions#new"
end
