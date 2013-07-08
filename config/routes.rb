Pro_assign_compiler::Application.routes.draw do

  match '/', to: 'static_pages#home'

    root to: 'static_pages#home'
    match '/home',   to: 'static_pages#home'
    match '/help',   to: 'static_pages#help'
    match '/about',   to: 'static_pages#about'
    match '/error', to: 'static_pages#error'
    match '/dashboard/:id',   to: 'static_pages#dashboard', :as => "dashboard"
    match '/contests/:id/register', to: 'contests#register', via: 'GET', :as => "register"
    match '/contests/:id/unregister', to: 'contests#unregister', via: 'GET', :as => "unregister"
    match '/contests/admin', to: 'contests#admin_index', via: 'GET', :as => "admin_contests"
    match '/contests/admin/:id', to: 'contests#admin', via: 'GET', :as => "admin_contest"
    match '/contests/start/:id', to: 'contests#start', via: 'GET', :as => "start"
    match '/contests/finalize/:id', to: 'contests#finalize', via: 'GET', :as => "finalize"
    match '/contests/active/:id', to: 'contests#active', via: 'GET', :as => "active"


    resources :users do
      resources :solutions
    end


    resources :states, only: [:index]
    resources :contests
    resources :problems do
    end
    resources :sessions, only: [:new, :create, :destroy]
    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    get "signup" => "users#new", :as => "signup"




#end #locale

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
