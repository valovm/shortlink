Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :urls, only: %i[show create] do
        member do
          get :stats
        end
      end
    end
  end
end
