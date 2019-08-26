Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/auth/login', to: 'auth#login'
  delete 'auth/logout', to: 'auth#logout'
  get '/*a', to: 'application#not_found'
end
