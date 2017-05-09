Rails.application.routes.draw do
  get "login"     => "user_sessions#new",     :as => :login
  post "login"     => "user_sessions#new",     :as => :checkout_login
  get "logout"    => "user_sessions#destroy", :as => :logout
  get "register"  => "users#new",             :as => :register

  get "shop"                        => "products#index"
  get "shop/our-coffee-portfolio"   => "products#index"
  get "shop/our-portfolio"          => "products#index"
  get "meet"                        => "pages#show",                                                :section_slug => "meet",      :page_slug => "snapshot"
  get "learn"                       => "pages#show",                                                :section_slug => "learn",     :page_slug => "the-muskoka-roastery-difference"
  get "sustain"                     => "pages#show",                                                :section_slug => "sustain",   :page_slug => "100-certified"
  get "contact"                     => "feedbacks#contact",           :as => :contact,              :section_slug => "none"
  get "company/contact-us"          => "feedbacks#contact",           :as => :contact_us,           :section_slug => "none"
  get "company/:page_slug"          => "pages#show",                  :as => :show_no_page,         :section_slug => "none"
  get "where-to-buy"                => "places#where_to_buy",         :as => :where_to_buy,         :section_slug => "none"
  get "places/where-to-buy-search"  => "places#where_to_buy_search",  :as => :where_to_buy_search
 
  get '/subscriptions', to: "orders#subscriptions" 
  get "/subscription", to: "products#subscription"
  get "blog"                                          => "blog_posts#index",      :as => :blog
  get "blog/category/:slug"                           => "blog_posts#category",   :as => :blog_category_show
  get "blog/:slug"                                    => "blog_posts#show",       :as => :blog_post_show
  get "blog_categories/:id/sort/:new_position"        => "blog_categories#sort",  :as => :blog_category_sort

  patch "pages/update_homepage_title"                 => "pages#update_homepage_title"
  put "pages/update_homepage_title"                   => "pages#update_homepage_title"
  get "pages/:id/sort/:new_position"                  => "pages#sort",            :as => :page_sort
  get "products/:id/sort/:new_position"               => "products#sort",         :as => :product_sort
  get "stay-connected"                                => "pages#connect"
  get "homepage1"                                     => "pages#homepage1"
  
  get '/cancel_order', to: "shopping_cart#cancel_pay_now" 
  # AJAX URL for newsletter signups.
  post "feedbacks/newsletter_signup" => "feedbacks#newsletter_signup", :as => :newsletter_signup

  get "products/:product_id/product_flavours/:id/sort/:new_position" => "product_flavours#sort", :as => :product_flavours_sort

  get "shopping_cart"                                 => "orders#show",                               :as => :current_order,  :id => "current"
  post "shopping_cart/add_discount"                   => "shopping_cart#add_discount",                :as => :add_discount
  get "shop/category/:slug"                           => "products#category",                         :as => :shop_category
  get "shop/categories"                               => "shopping_cart#categories",                  :as => :shop_categories
  get "shop/cart/:id"                                 => "shopping_cart#shopping_cart",               :as => :shop_cart
  post "shop/add_to_cart/:id"                         => "products#add_to_cart",                      :as => :add_product_to_cart
  get "shop/products/:slug"                           => "products#show",                             :as => :shop_product
  # match "shop/products/:id"                           => "products#show",                             :as => :shop_product
  get "shop/empty_cart"                               => "shopping_cart#empty_cart",                  :as => :shop_empty_cart
  get "shop/checkout"                                 => "shopping_cart#checkout",                    :as => :shop_checkout
  get "shop/thankyou"                                 => "shopping_cart#thankyou",                    :as => :shop_thankyou
  get "shop/thankyou/:subscription_code"              => "shopping_cart#thankyou",                    :as => :shop_thankyou1
  get "shop/one_more_item/:id"                        => "shopping_cart#one_more_item",               :as => :shop_one_more_item
  get "shop/one_less_item/:id"                        => "shopping_cart#one_less_item",               :as => :shop_one_less_item
  get "shop/remove_item/:product_id/:option/:flavour" => "shopping_cart#remove_item",                 :as => :shop_remove_item
  post "shop/place_order"                             => "shopping_cart#place_order",                 :as => :shop_place_order
  get "shop/review_order"                             => "shopping_cart#review_order",                 :as => :review_order

  post "shop/order_review_update_totals"              => "shopping_cart#order_review_update_totals",  :as => :order_review_update_totals
  get "shop/update_totals"                            => "shopping_cart#update_totals",               :as => :update_totals
  get "shop/submit_to_paypal/:id"                     => "shopping_cart#submit_to_paypal",            :as => :shop_submit_to_paypal

  resources :password_resets, :except => [:show, :index]
  resources :backgrounds
  resources :shipping_rates
  resources :discounts
  resources :documents
  resources :payment_notifications
  resources :line_items
  resources :orders
  resources :feedbacks
  resources :images do
    collection do
      get :browse
      post :upload
    end
  end
  resources :blog_categories
  resources :blog_posts
  resources :features do
    collection do
      put :update_left
      put :update_middle
      put :update_right
      get :edit_left
      get :edit_middle
      get :edit_right
    end
  end
  resources :pages do
    collection do
      get :edit_homepage_title
      put :update_homepage_title
    end
  end
  resources :product_types
  resources :products do
    collection do
      get :order
      put :sort
    end
    resources :product_flavours
  end
  resources :places
  resources :users
  resources :user_sessions
  resources :subscriptions


  get ":section_slug"             => "pages#show", :overview => true, :as => :show_section
  get ":section_slug/:page_slug"  => "pages#show",                    :as => :show_page

  root :to => "pages#homepage"

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
