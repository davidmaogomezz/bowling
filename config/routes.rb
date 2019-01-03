Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  get 'home/add_player' => 'home#add_player'
  get 'home/add_score' => 'home#add_score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
