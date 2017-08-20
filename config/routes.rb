Rails.application.routes.draw do
  resources :items do
  	member do
  		patch :complete
  	end
  end

  root "items#index"
  end
