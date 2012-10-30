Psychedelica::Application.routes.draw do
  get "/status.json" => 'status#index'
end
