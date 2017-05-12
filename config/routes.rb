Rails.application.routes.draw do
    root to: 'pages#home'
    get '/about', to: 'pages#about'

    get 'sign_up', to: 'users#new'
    resources :users, except: [:new]
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    resources :friendships
    
    get 'friends', to: 'users#friends'
    get 'search_friends', to: 'users#search'
    post 'add_friend', to: 'users#add_friend'

    resources :articles do
        resources :comments
        member do
            put "like", to: "articles#upvote"
            put "dislike", to: "articles#downvote"
        end
    end
     
    resources :categories
    

end
