# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  number      :string(255)
#  name        :string(255)
#  description :text(65535)
#  content     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Course < ActiveRecord::Base
	#评论回复
	acts_as_commentable  
	#关注、喜欢、收藏
	acts_as_votable
	
	acts_as_commentable
	has_one :image, as: :imageable
	has_many :sub_courses, dependent: :destroy

	before_create do
		self.number = NumberHelper.random_course_number
  end
end
