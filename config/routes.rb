Rastaman::Application.routes.draw do

  root                                     'site#index'
  get     'about-us'                    => 'site#about'
  get     'restricted-area'             => 'site#restricted'

  get     'login'                       => 'session#new',                  as: :login
  post    'login'                       => 'session#create'
  delete  'logout'                      => 'session#destroy'

  get     'register/:sign_up_code'      => 'registration#new',             as: :register
  post    'register/:sign_up_code'      => 'registration#create'

  get     'reset/:password_reset_code'  => 'password#edit_reset',          as: :reset
  patch   'reset/:password_reset_code'  => 'password#update_reset'  
  get     'profile/update-password'     => 'password#edit_change',         as: :profile_edit_password
  patch   'profile/update-password'     => 'password#update_change'

  get     'profile'                     => 'profile#index'
  get     'profile/edit'                => 'profile#edit',                 as: :profile_edit
  patch   'profile/edit'                => 'profile#update'

end
