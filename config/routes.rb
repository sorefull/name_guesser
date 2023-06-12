Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'country_guess', to: 'country_guess#index'
  get 'calculator', to: 'calculator#index'
end
