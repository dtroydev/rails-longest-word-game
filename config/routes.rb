Rails.application.routes.draw do
  root 'games#new'
  get 'new' => 'games#new'
  post 'score' => 'games#score'
  # root to: 'games#new'
  # get 'new', to: 'games#new'
  # post 'score', to: 'games#score'
end
