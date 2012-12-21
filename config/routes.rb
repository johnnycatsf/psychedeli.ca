Psychedelica::Application.routes.draw do
  get "/status.json" => 'status#index', format: :json
  resources :articles, only: [:index, :show] do
    collection { post :clear }
    member { get :partial }
  end
  get "/:year/:month/:day/:title" => 'articles#show'
  root to: "articles#index"
end
