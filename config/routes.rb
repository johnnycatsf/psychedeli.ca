Psychedelica::Application.routes.draw do
  get "/status.json" => 'status#index'
  mount '/tent' => TentD::Admin
end
