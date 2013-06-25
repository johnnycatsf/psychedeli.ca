Psychedelica::Application.routes.draw do
  #get "/status.json" => 'status#index', format: :json

  resources :articles, only: [:index, :show] do
    collection { post :clear }
  end

  get "/:year/:month/:day/:title" => 'articles#show'
  get "/:category" => 'articles#index', :as => :category
  get "/tag/:tag" => 'articles#index', :as => :tag

  get '/info/:id' => 'high_voltage/pages#show'

  root to: 'articles#index'
end
