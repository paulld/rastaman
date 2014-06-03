Rastaman::Application.routes.draw do
  root 'site#index'

  get 'login' => 'session#new'
  post 'login' => 'session#create'
  
end
