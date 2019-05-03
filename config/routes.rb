Rails.application.routes.draw do
  root to: "homepages#index"

  resources :reviews, only: [:new, :create] # might not need new

  resources :categories, only: [:new, :create, :show]

  get "/orders/empty", to: "orders#empty_order", as: "empty_order" # this has to be above resources :orders

  resources :orders, except: [:new] # might not need index
  get "/orders/cust_info", to: "orders#cust_info", as: "cust_info"
  patch "/orders/submit", to: "orders#submit", as: "submit"

  resources :orderitems, only: [:create, :edit, :update, :destroy] # clarify this more later #added create

  resources :products, except: [:destroy]
  patch "/products/retire", to: "products#retire", as: "retire"

  resources :users, only: [:index, :show]
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#login", as: "auth_callback"
  delete "/users/logout", to: "users#logout", as: "logout"
  get "/myaccount", to: "users#myaccount", as: "myaccount"
  get "/myaccount/orders", to: "users#myorders", as: "myorders"
end
