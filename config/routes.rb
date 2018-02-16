Rails.application.routes.draw do
  get 'imports/index'
  root to: 'imports#index'
end
