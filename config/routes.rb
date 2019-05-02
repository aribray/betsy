Rails.application.routes.draw do
  root to: "homepages#index"

  resources :reviews, only: [:new, :create] # might not need new

  resources :categories, only: [:new, :create, :show]

  resources :orders, except: [:new] # might not need index
  get "/orders/cust_info", to: "orders#cust_info", as: "cust_info"
  patch "/orders/submit", to: "orders#submit", as: "submit"

  resources :orderitems, only: [:edit, :update, :destroy] # clarify this more later

  resources :products, except: [:destroy]
  patch "/products/retire", to: "products#retire", as: "retire"

  resources :users, only: [:index, :show]
  get "/users/login" # authentication stuff... do this later
  get "/users/logout", to: "users#logout", as: "logout"
  get "/myaccount", to: "users#myaccount", as: "account"
  get "/myaccount/orders", to: "users#orders", as: "user_orders"
end
