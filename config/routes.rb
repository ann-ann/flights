Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :flights, only: [:index, :prefered_flight] do
        collection do
          get :prefered_flight
        end
      end
    end
  end
end
