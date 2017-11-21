Rails.application.routes.draw do


  resources :registers, only: [:show, :index] do

    resources :year, only: [:show], path: 'updates', constraints: {id: /\d{4}/} do
      resources :month, only: [:show], path: '', constraints: {id: /\d{2}/} do
        resources :day, only: [:show], path: '', constraints: {id: /\d{2}/}, controller: 'register_update_day'
      end
    end

    resources :records, only: [:show], path: '', :constraints => {:id => /.*/ }

  end


  root to: "home#show"

end
