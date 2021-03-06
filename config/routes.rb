Rails.application.routes.draw do
  root to: "homepages#index"

  resources :categories, only: [:new, :create, :show]

  get "/orders/empty", to: "orders#empty_order", as: "empty_order" # this has to be above resources :orders

  resources :orders, except: [:new, :create, :index]

  get "/cart", to: "orders#cart", as: "cart"
  get "/checkout", to: "orders#checkout", as: "checkout"

  patch "/submit_order", to: "orders#submit", as: "submit"

  get "/confirmation", to: "orders#confirmation", as: "confirmation"

  resources :orderitems, only: [:create, :edit, :update, :destroy] # clarify this more later #added create
  patch "orderitems/:id/ship", to: "orderitems#ship", as: "ship"

  resources :products, except: [:destroy] do
    resources :reviews, only: [:create]
  end

  patch "/products/:id/retire", to: "products#retire", as: "retire"

  resources :users, only: [:index, :show]
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#login", as: "auth_callback"
  delete "/users/logout", to: "users#logout", as: "logout"
  get "/myaccount", to: "users#myaccount", as: "myaccount"
  get "/myaccount/orders", to: "users#myorders", as: "myorders"
end
