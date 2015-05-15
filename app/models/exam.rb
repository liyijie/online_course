# == Schema Information
#
# Table name: exams
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  sub_course_id :integer
#  total_score   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :sub_course
  has_many :exam_items
end
