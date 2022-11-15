Rails.application.routes.draw do
  devise_for :users
  resources :cryptos
  root to: "pages#home"
end
