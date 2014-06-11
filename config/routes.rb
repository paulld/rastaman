Rastaman::Application.routes.draw do

  root                                     'site#index'
  get     'about-us'                    => 'site#about'
  get     'restricted-area'             => 'site#restricted'

  get     'login'                       => 'session#new'
  post    'login'                       => 'session#create'
  delete  'logout'                      => 'session#destroy'

  get     'register/:sign_up_code'      => 'registration#new',    as: :register
  post    'register/:sign_up_code'      => 'registration#create'

  get     'reset/:password_reset_code'  => 'password#edit',       as: :reset
  patch   'reset/:password_reset_code'  => 'password#update'

  get     'profile'                     => 'profile#index',       as: :profile
  get     'profile/edit'                => 'profile#edit'
  patch   'profile/edit'                => 'profile#update'

end
