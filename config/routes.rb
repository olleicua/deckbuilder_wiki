Rails.application.routes.draw do
  root "decks#index"
  resources :decks, except: :index
  resources :inclusions, only: [:create, :edit, :destroy]
  get "/query/:q", to: "cards#query"
end
