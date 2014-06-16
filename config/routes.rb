Rastaman::Application.routes.draw do

  root                                         'site#index'
  get     'about-us'                        => 'site#about'
  get     'restricted-area'                 => 'site#restricted'

  get     'login'                           => 'session#new',                  as: :login
  post    'login'                           => 'session#create'
  delete  'logout'                          => 'session#destroy'

  get     'register/:registration_code'     => 'registration#new',             as: :register
  post    'register/:registration_code'     => 'registration#create'

  get     'reset/:password_reset_code'      => 'password_reset#edit',          as: :reset
  patch   'reset/:password_reset_code'      => 'password_reset#update'

  get     'profile'                         => 'profile#index'
  get     'profile/edit'                    => 'profile#edit',                 as: :profile_edit
  patch   'profile/edit'                    => 'profile#update'
  get     'profile/update-password'         => 'profile#edit_password',        as: :profile_edit_password
  patch   'profile/update-password'         => 'profile#update_password'

end
