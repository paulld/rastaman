Rastaman::Application.routes.draw do

  root                                     'site#index'
  get     'about-us'                    => 'site#about'
  get     'restricted-area'             => 'site#restricted'

  get     'login'                       => 'session#new'
  post    'login'                       => 'session#create'
  delete  'logout'                      => 'session#destroy'

  get     'register/:sign_up_code'      => 'registration#new',    as: :register
  post    'register/:sign_up_code'      => 'registration#create'

  get     'reset/:password_reset_code'  => 'reset#edit',          as: :reset
  patch   'reset/:password_reset_code'  => 'reset#update'

end
