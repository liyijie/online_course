Rails.application.routes.draw do
  devise_for :users
  devise_for :teachers
  root :to => "home#index"
  get "courses/:number", to: "courses#show", as: :show_courses
  get "courses/:number/after_class", to: "courses#after_class", as: :after_class_courses
  get "courses/:number/sub_courses/:number", to: "sub_courses#show", as: :show_sub_courses_courses
  get "courses/:number/exams/new", to: "exams#new", as: :new_courses_exams

  #当子课程为pdf等格式文件时下载链接
  get "/sub_courses/:number/download", to: "sub_courses#download", as: :download_sub_course

  resources :courses, only: [:index] do
  	resources :sub_courses, only: [:show]
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
      get :my_questions
      get :my_answers
      get :my_score
      post :select_grade
      post :select_course
      post :show_score
    end
    member do
      patch :update_password
    end
  end

  resources :exams, only: [:new, :create, :show]

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
    resources :courses do
      resources :sub_courses do
        resources :questions, only: [:index] do
          collection do
            post :import
          end
        end
      end
    end
  end

end
