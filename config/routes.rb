Rails.application.routes.draw do
  devise_for :users
  devise_for :teachers
  root :to => "home#index"
  get "courses/:number", to: "courses#show", as: :show_courses
  resources :courses, only: [:index] do
  	resources :sub_courses
  end

  resources :exams, only: [:new, :create]

  resources :user, only: [:show, :update] do
  	collection do
      post 'get_specialties'
      post 'get_grades'
    end
  end

end
