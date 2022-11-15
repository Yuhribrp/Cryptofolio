Rails.application.routes.draw do
  devise_for :users
  resources :cryptos
  root to: "pages#home"
  get 'pages/live_market'
  post '/pages/live_market' => 'pages/live_market'
end
