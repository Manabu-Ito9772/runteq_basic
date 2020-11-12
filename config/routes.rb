Rails.application.routes.draw do
  root 'static_pages#top'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  get '/profile', to: 'profiles#show'
  get 'edit/profile', to: 'profiles#edit'
  resources :users
  resources :boards do
    resources :comments, shallow: true
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[create destroy]
  resources :password_resets
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
