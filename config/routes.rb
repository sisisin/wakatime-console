Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :summaries    
    end
  end

  get 'summaries/index'

  get 'dashboard/index'
  root 'dashboard#index'
end
