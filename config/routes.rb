Rastaman::Application.routes.draw do
  root 'site#index'

  get 'login' => 'session#new'
  post 'login' => 'session#create'

  get 'about' => 'about#index'

  get 'credits' => 'credits#index'

end
