# == Schema Information
#
# Table name: papers
#
#  id          :integer          not null, primary key
#  teacher_id  :integer
#  course_id   :integer
#  name        :string(255)
#  content     :text(65535)
#  start_at    :date
#  end_at      :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  total_score :integer
#

require 'rails_helper'

RSpec.describe Paper, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
