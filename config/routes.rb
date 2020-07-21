Rails.application.routes.draw do
  post 'contacts/create'
  root to: 'contacts#index'
  # root to: 'contacts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
