Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root "books#index"
  resources :articles
  resources :books

  get 'video-gallary' => "books#yt_videos"
  get  'fav_videos', to: 'videos#show_all_fav_videos'
  
  resources :videos do 
    member do 
      post :add_to_favourite
      post :remove_from_favourite
    end
  end
end
