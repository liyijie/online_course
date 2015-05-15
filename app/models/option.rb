# == Schema Information
#
# Table name: options
#
#  id          :integer          not null, primary key
#  index_type  :string
#  name        :string
#  be_right    :boolean
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Option < ActiveRecord::Base
  belongs_to :question
end
