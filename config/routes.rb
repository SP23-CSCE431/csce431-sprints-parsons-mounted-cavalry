Rails.application.routes.draw do
  root "staffs#index"
    
  resources :cadets do
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
  
  resources :staffs do
    member do 
      get :delete 
    end
  end

end
