Psychedelica::Application.routes.draw do
  get "/status.json" => 'status#index', format: :json
  resources :articles, only: [:index, :show] do
    collection { post :clear }
  end
  get "/:year/:month/:day/:title" => 'articles#show'
  root to: "high_voltage/pages#show", id: 'about'
end
