# frozen_string_literal: true

Rails.application.routes.draw do
  root 'namespaces#index'

  namespace :api, defaults: { format: 'json' } do
    scope module: :v1 do
      get '', to: 'root#index', as: :root

      resources :namespaces, only: %i[index show] do
        resources :pages, only: %i[index show]
      end
    end
  end

  get 'new' => 'namespaces#new'
  get 'search' => 'search#index'

  # Occupy remaining root namespace
  # (place route declarations above this)

  resources :namespaces, path: '' do
    member do
      get 'edit'
    end

    resources :pages, path: '' do
      collection do
        get 'random'
      end

      member do
        get 'rendered'
        get 'source'
        get 'markdown'
        get 'urls'
        get 'next'
        get 'previous'
      end

      resources :uploads, only: %i[index create]
      resources :versions, only: [:index] do
        member do
          post 'restore'
        end
      end
    end
  end
end
