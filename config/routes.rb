Rails.application.routes.draw do
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  devise_for :users
  devise_for :teachers
  root :to => "home#index"

  get "select_courses", to: "home#select_courses", as: :select_courses_home
  get "courses/:number", to: "courses#show", as: :show_courses
  get "courses/:number/after_class", to: "courses#after_class", as: :after_class_courses

  #限定子课程编号为数字
  constraints(number: /\d+/) do
    get "sub_courses/:number", to: "sub_courses#show", as: :show_sub_courses
  end
  get "courses/:number/exams/new", to: "exams#new", as: :new_courses_exams

  post "sub_courses/comment_create_list"
  get "sub_courses/comment_create_list"
  post "sub_courses/reply_comment_list"
  get "sub_courses/comment_praise"
  post "sub_courses/collect_or_praise"
  
  #当子课程为pdf等格式文件时下载链接
  get "/sub_courses/:number/download", to: "sub_courses#download", as: :download_sub_course

  resources :courses, only: [:index] do
  	resources :sub_courses, only: [:show]
    collection do
      post :course_collect
      post :course_praise
    end
  end

  resources :sub_courses, only: [:new, :create, :edit, :update, :destroy]

  #讨论中心
  resources :discusses, except: [:edit, :update, :destroy] do 
    collection do
      post :reply_topic
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
      post :my_score
      post :select_grade
      post :select_course
      post :show_score
      get :show_grade_score
      post :upload_attachment
      get :import_question
      post :import
    end
    member do
      patch :update_password
      get :get_sub_course
      get :grade_students
    end
  end

  resources :exams, only: [:new, :create, :show, :index]  do 
    collection do
      get :test_new
      get :show_test
    end
  end

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

      post :update_password
    end
  end
  
  namespace :admin do
    root "home#index"
    resources :specialties
    resources :questions, only: [] do
      collection do
         post :import
      end
    end
    resources :courses do
      resources :sub_courses do
        resources :questions, only: [:index]
      end
    end

    resources :teachers do
      collection do
        post :import
      end
    end

    resources :academies

    resources :users do
      collection do
        post :import
      end
    end
  end

end
