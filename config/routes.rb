Rails.application.routes.draw do
  root to: "pokemons#index"

  resources :pokemons, only: [:index, :show] do
    resources :pokeballs, only: [:create]
  end

  resources :pokeballs, only: [:destroy]
  resources :trainers, only: [:index, :show]

end

