Rails.application.routes.draw do
  root "users#index"
    
  resources :users do
    member do
      get :delete
    end
    collection do
      get :cadets
      get :staffs
      get :admins
    end
  end


  resources :horses do
    member do
      get :delete
    end
  end
  
  resources :attendances

end
