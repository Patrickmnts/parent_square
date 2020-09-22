Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages, :only => [:create],
            :defaults => { :format => 'json' }

  post 'message/:id/set_delivery_status', to: 'messages#set_delivery_status', as: 'set_delivery_status'
end
