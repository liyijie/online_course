# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  title         :string
#  signal_score  :integer
#  sub_course_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Question < ActiveRecord::Base
  belongs_to :sub_course
  has_many :options
end
