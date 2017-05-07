Rails.application.routes.draw do
    root to: 'pages#home'
    get '/about', to: 'pages#about'

    get 'sign_up', to: 'users#new'
    resources :users, except: [:new]

    resources :articles
end
