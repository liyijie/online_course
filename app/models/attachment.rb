# == Schema Information
#
# Table name: attachments
#
#  id                   :integer          not null, primary key
#  sub_course_id        :integer
#  content              :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  content_file_name    :string(255)
#  content_content_type :string(255)
#  content_file_size    :integer
#

class Attachment < ActiveRecord::Base
  belongs_to :sub_course
  has_attached_file :content
  validates_attachment :content, :content_type => {:content_type => %w(video/mp4 image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}
end
