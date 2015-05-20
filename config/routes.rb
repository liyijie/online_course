Rails.application.routes.draw do
  devise_for :users
  devise_for :teachers
  root :to => "home#index"
  get "courses/:number", to: "courses#show", as: :show_courses
  get "courses/:number/exams/new", to: "exams#new", as: :new_courses_exams
  get "teachers/:number/my_courses", to: "teachers#my_courses", as: :my_courses_teachers
  resources :courses, only: [:index] do
  	resources :sub_courses
  end

  resources :exams, only: [:new, :create]

  resources :user, only: [:show, :update] do
  	collection do
      post 'get_specialties'
      post 'get_grades'
      get 'show'
      get 'my_courses'
      get 'my_exams'
      get 'score_search'
      get 'my_collect'
      get 'questions_answers'
      get 'discuss_center'
    end
  end

end
