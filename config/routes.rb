Rails.application.routes.draw do
  root 'loadout#show'
  post 'randomize', to: 'loadout#randomize'
end
