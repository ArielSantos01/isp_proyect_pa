Rails.application.routes.draw do
  #member -> :id
  #collection -> sin id
  #RUTAS
  resources :clients, only: [:create]

  resources :isps, only: [:create] do
    collection do
      get :plans   
    end
  end

  resources :plans, only: [:create, :index] do
    member do
      post :create_request
      post :change_request
    end
  end

  resources :requests, only: [:index] do
    collection do
      get :rejected_request
    end
    member do
      put :approve 
      put :rejected
    end
  end

end
