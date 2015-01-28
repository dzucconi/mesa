Rails.application.routes.draw do
  root 'pages#index'

  resources :pages, path: '' do
    member do
      get 'source'
    end
  end
end
