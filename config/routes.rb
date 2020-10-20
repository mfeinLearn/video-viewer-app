Rails.application.routes.draw do

namespace :api do
    resources :videos, only: [:index, :create, :show]
end

end
