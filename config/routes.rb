Wallgig::Engine.routes.draw do
  resources :users, only: [:show, :create, :update] do
    member do
      get 'auth_token'
    end
  end
end