Rails.application.routes.draw do
  root 'namespaces#index'

  namespace :api, defaults: { format: 'json' } do
    scope module: :v1 do
      get '', to: 'root#index', as: :root

      resources :namespaces, only: [:index, :show] do
        resources :pages, only: [:index, :show]
      end
    end
  end

  get 'new' => 'namespaces#new'

  # Occupy remaining root namespace
  # (place route declarations above this)

  resources :namespaces, path: '' do
    member do
      get 'edit'
    end

    resources :pages, path: '' do
      member do
        get 'source'
      end

      resources :uploads, only: [:index, :create]
      resources :versions, only: [:index]
    end
  end
end
