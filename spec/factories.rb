require 'rack/test'

FactoryGirl.define do  factory :manager_course do
    manager nil
course nil
  end
  factory :manager do
    
  end
  factory :answer do
    user_paper nil
paper_question nil
content "MyString"
score 1
correct false
  end
  factory :paper_option do
    content "MyString"
index_type "MyString"
paper_question nil
  end
  factory :paper_qestion do
    paper nil
title "MyString"
correct_answer "MyString"
signal_score 1
correct_hint "MyText"
question_type 1
  end
  factory :user_paper do
    user nil
paper nil
total_score 1
  end
  factory :paper do
    
  end
  factory :category do
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