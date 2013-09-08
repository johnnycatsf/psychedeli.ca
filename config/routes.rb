Psychedelica::Application.routes.draw do
  resources :articles, only: [:index, :show]
  get "/:year/:month/:day/:title" => 'articles#show'
  get "/:category" => 'articles#index', :as => :category
  get "/tag/:tag" => 'articles#index', :as => :tag

  get '/info/:id' => 'high_voltage/pages#show'

  root to: 'articles#index'
end
