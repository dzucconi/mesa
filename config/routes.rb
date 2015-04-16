Rails.application.routes.draw do
  root 'namespaces#index'

  get 'new' => 'namespaces#new'

  resources :namespaces, path: '' do
    resources :pages, path: '' do
      member do
        get 'source'
      end
    end
  end
end
