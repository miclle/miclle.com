Miclle::Application.routes.draw do

  require 'sidekiq/web'

  get 'editors' => 'photos#editors'
  get 'recents' => 'photos#index'
  get 'screensaver' => "welcome#screensaver", :as => :screensaver

  # Favorites
  delete  'favorites/:type/:id' => "favorites#destroy", :as => :favorite
  post    'favorites/:type/:id' => "favorites#create",  :as => :favorites

  # Likes
  delete  'likes/:type/:id' => "likes#destroy", :as => :like
  post    'likes/:type/:id' => "likes#create",  :as => :likes

  resources :comments, :only => :destroy

  concern :comments do
    resources :comments, :only => :create
  end

  resources :photos, :concerns => :comments, :path => :photo, :path_names => { :new => :upload} do
    collection do
      post 'qiniu/callback' =>  'photos#qiniu_callback'
      get  'upload_to_qiniu'
    end
  end

  resources :albums

  resource :account, :except => [:create, :new] do
    member do
      get :password
      put :password
      get :notifications
    end
  end

  devise_for :users,
    :path => "user",
    :controllers => {
      :registrations => "users/registrations",
      :passwords     => "users/passwords"
    },
    :path_names => {
      :sign_up      => 'signup',
      :sign_in      => 'login',
      :sign_out     => 'logout'
      # :password     => 'secret',
      # :confirmation => 'verification',
      # :unlock       => 'unblock'
      # :registration => 'register'
    }

  resources :users, :only => [] do
    member do
      post  :follow, :unfollow
    end
  end


  namespace :cpanel do

    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end

    root 'dashboard#index'

    resources :users

    resources :photos do
      member do
        post :recommend
        post :unrecommend
      end
    end

    resources :comments
  end

  # if Rails.env.production?
    get '403', :to => 'application#render_403'
    get '404', :to => 'application#render_404'
    get '422', :to => 'application#render_422'
    get '500', :to => 'application#render_500'
  # end

  get ':username'           => 'users#show',      :as => :homepage_user
  get ':username/followers' => 'users#followers', :as => :followers_user
  get ':username/followed'  => 'users#followed',  :as => :followed_user
  get ':username/favorites' => 'users#favorites', :as => :favorites_user

  root 'welcome#index'

  # root 'welcome#updating'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
