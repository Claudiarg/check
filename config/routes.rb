Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/*a', to: 'application#not_found'

  #Auth
  post '/auth/login', to: 'auth#login'
  delete 'auth/logout', to: 'auth#logout'

  #Checker
  put '/check', to: 'checker#check'

end
