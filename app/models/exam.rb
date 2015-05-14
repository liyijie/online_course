class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :sub_course
  has_many :exam_items
end
