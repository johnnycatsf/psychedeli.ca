Psychedelica::Application.routes.draw do
  get "articles/index"

  get "articles/show"

  get "/status.json" => 'status#index'
end
