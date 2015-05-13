Rails.application.routes.draw do
  devise_for :users
  devise_for :teachers
  root :to => "home#index"

  get "courses/show", to: "courses#show"
  resources :courses, only: [:index] do
  	resources :sub_courses
  end 

end
