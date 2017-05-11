Rails.application.routes.draw do
    root to: 'pages#home'
    get '/about', to: 'pages#about'

    get 'sign_up', to: 'users#new'
    resources :users, except: [:new]
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :articles
    resources :categories
end
