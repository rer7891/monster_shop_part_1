Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  namespace :merchant, as: :merchant_dash do
    get '/merchant', to: 'merchant/dashboard#index'
  #   resources :items, only: [:index, :edit, :update, :destroy] do
  #     patch "/toggle_active", to: "items#toggle_active"
  #   end
  get '/merchant/itmes', to: 'merchant/items#index'
  get 'merchant/items/:id/edit', to: 'merchant/items#edit'
  patch '/merchant/items/:id', to: 'merchant/items#udpate'
  delete '/merchant/items/:id', to: 'merchant/items#destroy'

  #   resources :coupons do
  #     patch "/active", to: "couponstatus#update"
  #   end
  get '/merchant/coupons', to: 'merchant/coupons#index'
  get '/merchant/coupons/:id', to: 'merchant/coupons#show'
  get '/merchant/coupons/new', to: 'merchant/coupons#new'
  post '/merchant/coupons', to: 'merchant/coupons#create'
  get '/merchant/coupons/:id/edit', to: 'merchant/coupons#edit'
  patch '/merchant/coupons/:id', to: 'merchant/coupons#update'
  delete 'merchant/coupons/:id', to: 'merchant/coupons#destroy'

  #   resources :orders, only: [:show] do
  get '/merchant/orders/:id', to: '/merchant/orders#show'
  #     resources :item_orders, only: [] do
  #       patch "/fulfill", to: "orders#fulfill"
  #     end
  #   end
  #
  #   resources :items, only: [:index, :new, :create]
  get '/merchant/items', to: 'merchant/items#index'
  get '/merchant/items/new', to: 'merchant/items#new'
  post '/merchant/items', to: 'merchant/items#create'
  #   get "/", to: "dashboard#index"
   end



  namespace :admin, as: :admin_dash do
  #
  #   resources :users, only: [:index, :show, :edit, :update] do
  get '/admin/users', to: 'admin/users#index'
  get '/admin/users/:id', to: 'admin/users#show'
  get '/admin/users/:user_id/edit', to: 'admin/users#edit'
  patch '/admin/users/:user_id', to: 'admin/users#update'
  #     get "/edit_password", to: "users#edit_password"
  #     patch "/toggle_active", to: "users#toggle_active"
  #     get "/edit_role", to: "users#edit_role"
  #     patch "/role", to: "users#update_role"
  #
  #     resources :orders, only: [:show] do
  get 'admin/orders/:order_id', to: 'admin/orders#show'
  #       patch "/cancel", to: "orders#cancel"
  #       patch "/ship", to: "orders#ship"
  #     end
  #   end

  #   resources :merchants, only: [:index, :show] do
  get 'admin/merchants', to: 'admin/merchants#index'
  get 'admin/merchants/:id', to: 'admin/merchants#show'
  #     resources :items, only: [:index, :new, :create, :edit, :update]
  #     patch "/toggle_active", to: "merchants#toggle_active"
  get 'admin/merchants/:merchant_id/items', to: 'admin/items#index'
  get 'admin/merchants/:merchant_id/items/new', to: 'admin/items#new'
  get 'admin/merchants/:merchant_id/items', to: 'admin/items#create'
  get 'admin/merchants/:merchant_id/items/edit', to: 'admin/items#edit'
  get 'admin/merchants/:merchant_id/items/:item_id', to: 'admin/items#update'
  #   end
  #
  #   resources :items, only: [] do
  #     patch "/toggle_active", to: "items#toggle_active"
  #   end
  #
  #   resources :orders, only: [:update]
  patch '/admin/orders/:id', to: 'admin/orders#update'
  #   get "/", to: "dashboard#index"
  end

  # resources :merchants do
  #   resources :items, only: [:index, :new, :create]
  # end
  get '/merchants', to: 'merchants#index'
  get '/merchants/:id', to: 'merchants#show'
  get '/merchants/new', to: 'merchants#new'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'

  get '/merchants/:merchant_id/items', to: 'merchants/items#index'
  get '/merchants/:merchant_id/items/new', to: 'merchants/items#new'
  get '/merchants/:merchant_id/items', to: 'merchants/items#create'
  # resources :items do
  #   resources :reviews, only: [:new, :create]
  # end
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/items/:id/new', to: 'items#new'
  post '/items', to: 'items#create'
  get '/items/:id/edit', to: 'items#edit'
  patch '/items/:id', to: 'items#update'
  delete '/items/:id/', to: 'items#destroy'

  get '/items/:item_id/reviews/new', to: 'reviews#new'
  post '/items/:item_id/reviews', to: 'reviews#create'

  # resources :coupons, only: [:create]
  post '/coupons', to: 'coupons#create'

  # resources :reviews, only: [:edit, :update, :destroy]
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/profile", to: "users#show"
  get "/profile/edit", to: "users#edit"
  patch "/profile", to: "users#update"
  get "/profile/edit_password", to: "users#edit_password"

  get "/profile/orders", to: "user/orders#index"
  get "/profile/orders/new", to: "user/orders#new"
  get "/profile/orders/:id", to: "user/orders#show"
  post "/orders", to: "user/orders#create"
  patch "/profile/orders/:id/cancel", to: "user/orders#cancel"

  post "/cart/:item_id", to: "cart#add_item"
  patch "/cart/:item_id", to: "cart#add_subtract_cart"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
