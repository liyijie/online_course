# == Schema Information
#
# Table name: options
#
#  id          :integer          not null, primary key
#  index_type  :string(255)
#  name        :string(255)
#  be_right    :boolean
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted_at  :datetime
#

class Option < ActiveRecord::Base
  belongs_to :question
end
