Rails.application.routes.draw do

namespace :api do
    resources :videos, only: [:index, :create]
end

end
