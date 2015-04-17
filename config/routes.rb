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

  resources :namespaces, path: '' do
    resources :pages, path: '' do
      member do
        get 'source'
      end
    end
  end
end
