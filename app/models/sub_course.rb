# == Schema Information
#
# Table name: sub_courses
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  name       :string(255)
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  number     :string(255)
#

class SubCourse < ActiveRecord::Base
  acts_as_commentable
  belongs_to :course
  has_one :attachment
  has_many :questions, dependent: :destroy

  #创建sub_course生成编号
	before_create do
		self.number = NumberHelper.random_course_number
	end

  #判断附件格式是否是视频类
	def regex_video
		self.attachment && self.attachment.content_file_name && self.attachment.content.content_type =~ /video(.*)/
	end

  #判断附件格式是否是文档类
	def regex_res
		self.attachment && self.attachment.content_file_name && self.attachment.content.content_type =~ /application(.*)/
	end

  #计算附件大小
	def count_file_size
		size = ""
		if self.attachment && self.attachment.content_file_size
			if (self.attachment.content_file_size / 1048576) < 1
				size = (self.attachment.content_file_size / 1024).to_s + "KB"
			else
				size = (self.attachment.content_file_size / 1048576).to_s + "MB"
			end
		end
		size
	end
end