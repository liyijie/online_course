require 'rack/test'

FactoryGirl.define do  factory :category do
    name "MyString"
deleted_at "2015-07-21 10:39:26"
  end
  factory :teacher_grage do
    
  end
  factory :teacher_course do
    teacher nil
course nil
  end
  factory :user_course do
    user nil
course nil
  end
  factory :attachment do
    sub_course nil
content "MyString"
  end
  factory :image do
    
  end
  
  factory :question do
    title "试题1"
    subtitle "MyString"
  end

end