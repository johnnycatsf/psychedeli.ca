Psychedelica::Application.routes.draw do
  get "/status.json" => 'status#index', format: :json
  resources :articles, only: [:index, :show]
  get "/:year/:month/:day/:title" => 'articles#show'
  root to: "articles#index"
end
