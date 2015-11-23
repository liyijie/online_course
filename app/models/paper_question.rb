# == Schema Information
#
# Table name: paper_questions
#
#  id             :integer          not null, primary key
#  paper_id       :integer
#  title          :string(255)
#  correct_answer :string(255)
#  signal_score   :integer
#  correct_hint   :text(65535)
#  question_type  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PaperQuestion < ActiveRecord::Base
  belongs_to :paper
  has_one :answer, dependent: :destroy
  has_many :paper_options, dependent: :destroy

  enum question_type: {single: 1, multi: 2, judge: 3, fill: 4, que_an: 5}
  QUESTIONTYPE = {single: "单选题", multi: "多选题", judge: "判断题", fill: "填空题", que_an: "问答题"}

end
