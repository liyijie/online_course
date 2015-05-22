# == Schema Information
#
# Table name: attachments
#
#  id            :integer          not null, primary key
#  sub_course_id :integer
#  content       :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Attachment < ActiveRecord::Base
  belongs_to :sub_course
end
