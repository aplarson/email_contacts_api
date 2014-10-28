Rails.application.routes.draw do
 resources :users, only: [:index, :show, :create, :update, :destroy] do
   resources :contacts, only: :index
   resources :comments, only: :index
   resources :contact_groups, only: :index
 end
 resources :contacts, only: [:show, :create, :update, :destroy] do
   resources :comments, only: :index
   member do
     get 'favorite'
   end
 end
 resources :contact_shares, only: [:create, :destroy] do
   member do
     get 'favorite'
   end
 end
 resources :comments, only: [:show, :create, :update, :destroy]
 resources :contact_groups, only: [:show, :create, :update, :destroy]
 resources :contact_group_memberships, only: [:create, :destroy]
end
