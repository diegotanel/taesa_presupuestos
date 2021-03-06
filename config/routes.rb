SampleApp::Application.routes.draw do

  resources :partidas_contable

  resources :clientes_proveedores

  # match "partidas_contable/:id/dar_por_cumplida" => "partidas_contable#dar_por_cumplida", :as => :partida_contable_dar_por_cumplida

  resources :cotizaciones_peso_dolar_historico, :only => :index
  resources :saldos_bancario_historico, :only => :index
  resources :partidas_contable do
    resources :cancelaciones, :only => [:index, :new, :create, :destroy]
    member do
      put :dar_por_cumplida
    end
  end
  resources :motivos_de_baja_presupuestaria
  resources :medios_de_pago
  resources :productos_trabajos
  resources :canales_de_solicitud
  resources :rubros
  resources :solicitantes
  resources :empresas
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :roles, :only => :update
  resources :bancos
  resources :cotizaciones_peso_dolar, :only => [:edit, :update]
  resources :saldos_bancario, :only => [:edit, :update, :destroy]  do
    member do
      put :activar
    end
  end
  resources :informes_presupuestario, :only => [:index, :show]


  match '/signup',  :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  match '/home', :to => 'pages#home'

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
  root :to => 'sessions#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
