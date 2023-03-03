Rails.application.routes.draw do
  root "pages#index"
    
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
  
  resources :attendances

end
