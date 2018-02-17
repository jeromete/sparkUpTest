Rails.application.routes.draw do
  get 'users/index'

  resources :imports do
    collection do
      post :import
    end
  end
  get 'imports/index'
  root to: 'imports#index'
end
