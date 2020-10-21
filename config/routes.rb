Rails.application.routes.draw do

namespace :api do
    resources :videos, only: [:index, :create, :show, :update, :destroy]
end

end
