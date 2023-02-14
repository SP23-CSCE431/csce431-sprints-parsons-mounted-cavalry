Rails.application.routes.draw do

  root to: "horses#index"
    
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

end
