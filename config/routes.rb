Rails.application.routes.draw do

namespace :api do
    resources :videos, only: [:index, :create, :show, :update, :destroy] do
        resources :comments, only: [:index, :create, :destroy]
    end
end

end
