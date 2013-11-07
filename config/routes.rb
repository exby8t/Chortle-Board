ChoreBoardApp::Application.routes.draw do

  get "/panel" => 'admin_panel#index', :as => :admin_home

  root :to => 'home#index'
  
  get "home/index", :as => :home
  get "home/about", :as => :about
  
  get '/login' => 'login#index', :as => :login
  post '/login' => 'login#authenticate', :as => :process_login
  get '/logout' => 'login#logout', :as => :logout

  resources :todos
  resources :tasks
  resources :intervals
  resources :categories


  #match ':family_id/:controller/(:action)/(:id)' 

  resources :administrators
  resources :members
  resources :member_types
  resources :families

  resources :families, path: "/" do 
     resources :members
     resources :tasks
     resources :todos
  end

  get ":family_id/todos/list" => 'todos#list', :as => :family_todos_list
  match '/todos/:id/assign/:member_id' => 'todos#assign', :as => :assign_todo
  match '/todos/:id/unassign/:member_id' => 'todos#unassign', :as => :unassign_todo

    match '/todos/:id/complete/:member_id' => 'todos#complete', :as => :complete_todo
  match '/todos/:id/incomplete/:member_id' => 'todos#incomplete', :as => :incomplete_todo

end
