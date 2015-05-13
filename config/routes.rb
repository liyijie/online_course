Rails.application.routes.draw do


  devise_for :users
  devise_for :teachers

  get 'home/index'

  root :to => "home#index"

end
