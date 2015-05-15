# == Schema Information
#
# Table name: exam_items
#
#  id          :integer          not null, primary key
#  exam_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  answer      :string
#  correct     :boolean
#  item_index  :integer
#

class ExamItem < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question
end
