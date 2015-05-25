Rails.application.routes.draw do
  devise_for :users
  devise_for :teachers
  root :to => "home#index"
  get "courses/:number", to: "courses#show", as: :show_courses
  get "courses/:number/after_class", to: "courses#after_class", as: :after_class_courses
  get "courses/:number/sub_courses/:number", to: "sub_courses#show", as: :show_sub_courses_courses
  get "courses/:number/exams/new", to: "exams#new", as: :new_courses_exams

  resources :courses, only: [:index] do
  	resources :sub_courses
    collection do
      post :course_collect
      post :course_praise
    end
  end

  #限定教师编号为数字形式
  constraints(number: /\d+/) do
    get "teachers/:number", to: "teachers#show", as: :show_teachers
  end

  resources :teachers, only: [:index, :update] do
    collection do
      get :my_courses
      get :my_grades
      get :my_info
      get :my_account
      get :upload_course_ware
      get :discuss_center
      get :my_faqs
      get :my_score
    end
    member do
      patch :update_password
    end
  end

  resources :exams, only: [:new, :create]

  resources :user, only: [:show, :update] do
    collection do
      post :get_specialties
      post :get_grades
      get :show
      get :my_courses
      get :my_exams
      get :score_search
      get :my_collect
      get :my_questions
      get :my_answers
      get :discuss_center

      post :comment_create
      post :update_password
    end
  end

  namespace :admin do
    root "home#index"
    resources :courses
  end

end
