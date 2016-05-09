Rails.application.routes.draw do
  mount WeixinRailsMiddleware::Engine, at: "/"
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  devise_for :teachers, controllers: {
        sessions: 'teachers/sessions'
      }
  devise_for :managers, controllers: {
      sessions: 'managers/sessions'
    }
  root :to => "home#index"

  get "select_courses", to: "home#select_courses", as: :select_courses_home
  get "courses/:number", to: "courses#show", as: :show_courses
  get "courses/:number/after_class", to: "courses#after_class", as: :after_class_courses
  resources :errors, only: :index
  #限定子课程编号为数字
  constraints(number: /\d+/) do
    get "sub_courses/:number", to: "sub_courses#show", as: :show_sub_courses
    get "wechat/sub_courses/:number", to: "wechat/sub_courses#show", as: :show_wechat_sub_courses
  end
  get "courses/:number/exams/new", to: "exams#new", as: :new_courses_exams
  get "wechat/courses/:number/exams/new", to: "wechat/exams#new", as: :new_courses_wechat_exams
  get "wechat/courses/:number/exams/show_exam_result", to: "wechat/exams#show_exam_result", as: :show_exam_result_courses_wechat_exams

  post "sub_courses/comment_create_list"
  get "sub_courses/comment_create_list"
  post "sub_courses/reply_comment_list"
  get "sub_courses/comment_praise"
  post "sub_courses/collect_or_praise"
  #当子课程为pdf等格式文件时下载链接
  get "/sub_courses/:number/download", to: "sub_courses#download", as: :download_sub_course

  post "wechat/sub_courses/comment_create_list"
  get "wechat/sub_courses/comment_create_list"
  post "wechat/sub_courses/reply_comment_list"
  get "wechat/sub_courses/comment_praise"
  post "wechat/sub_courses/collect_or_praise"
  #当子课程为pdf等格式文件时下载链接
  get "wechat/sub_courses/:number/download", to: "wechat/sub_courses#download", as: :download_wechat_sub_course

  get "/learning_center", to: "courses#learning_center", as: :courses_learning_center
  resources :courses, only: [:index] do
  	resources :sub_courses, only: [:show]
    collection do
      post :course_collect
      post :course_praise
    end
  end

  resources :sub_courses, only: [:new, :create, :edit, :update, :destroy]

  #精品课程申报
  resources :apply_courses, only: [:index]

  #讨论中心
  resources :discusses, except: [:edit, :update, :destroy] do 
    collection do
      post :reply_topic
      get :sorts
      get :learns
      get :innovations
    end
  end

  # 测试中心
  resources :papers do
    member do
      get :questions
      patch :import
      get :students
    end

    resources :user_papers do
      collection do
        get :detail
        delete :destroy_grade
        get :export_grade
      end
    end
    resources :answers
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
      get :select_grade
      get :select_exam
      get :select_course
      get :show_score
      get :show_grade_score
      post :upload_attachment
      get :import_question
      post :import
      get :export
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
    resources :managers
    resources :specialties
    resources :questions, only: [] do
      collection do
         post :import
      end
    end
    resources :courses do
      member do
        post :delete, :delete, :restore
        patch :delete, :delete, :restore
      end
      resources :sub_courses do
        member do
          patch :higher, :lower, :delete, :restore
          post :lower, :higher, :delete, :restore
          delete :clearn
        end
        resources :questions, only: [:index, :destroy] do
          collection do
             get :clear
          end
        end
      end
    end

    resources :tags, only: [:index, :create]

    resources :teachers do
      collection do
        post :import
      end
    end

    resources :academies

    resources :categories do
      member do 
        get :tags
      end
    end

    resources :users do
      collection do
        post :import
      end
    end
  end

  # 微信
  namespace :wechat do
    root 'users#show'
    # 个人中心
    resources :users, only: [:edit, :update] do
      collection do
        get :my_exams
        get :my_courses
        get :edit_password
        get :persion_discusses
      end
      member do
        put :update_password
      end
    end
    resources :exams, only: [:new, :create, :show, :index]  do 
      collection do
        get :test_new
        get :show_test
      end
    end

    #讨论中心
    resources :discusses, except: [:edit, :update, :destroy] do 
      collection do
        post :reply_topic
        get :sorts
        get :learns
        get :innovations
      end
    end
    # 课程中心
    resources :courses, only:[:index, :show] do
      collection do
        post :course_collect
      end
      member do
        get :sub_course
        get :after_class_exams
      end 
    end

    resources :sub_courses, only:[:show] do
      post :comment_create_list
      get :comment_create_list
      post :reply_comment_list
      get :comment_praise
      post :collect_or_praise
    end
    
  end
end
