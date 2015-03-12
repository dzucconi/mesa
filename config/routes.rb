Rails.application.routes.draw do
  root 'pages#index'

  resources :pages, path: '' do
    collection do
      get 'all'
    end

    member do
      get 'source'
    end
  end
end
