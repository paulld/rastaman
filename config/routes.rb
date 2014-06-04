Rastaman::Application.routes.draw do
  root    'site#index'

  get     'login'                   => 'session#new'
  post    'login'                   => 'session#create'
  delete  'logout'                  => 'session#destroy'
  get     'logout'                  => 'session#destroy'  # TEMPORARY

  get     'about'                   => 'about#index'

  get     'credits'                 => 'credits#index'

  get     'register/:sign_up_code'  => 'registration#new', as: :register
  post    'register/:sign_up_code'  => 'registration#create'

end
