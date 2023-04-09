Rails.application.routes.draw do
  root "users#index"

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

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
    collection do
      get :staffs
      get :admins
    end
  end
  
  resources :attendances do
    member do
      get :delete
    end
    collection do
      get :cadets
      get :staffs
      get :admins
    end
  end

  resources :schedules do 
    member do
      get :delete
    end
    collection do
      get :cadets
      get :staffs
      get :admins
    end
  end

  resources :pages do
    collection do
      get :checkin_cadets
      get :checkin_staffs
      get :reports_admins
      get :reports_staffs
    end
  end
end
