Rails.application.routes.draw do
  resources :schedules
  root "users#index"
    
  resources :users do
    member do
      get :delete
    end
  end

  resources :horses do
    member do
      get :delete
    end
  end
  
  resources :attendances do
    member do
      get :delete
    end
  end

  resources :schedules do 
    member do
      get :delete
    end
  end

end
