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
	
	has_many :sub_courses, dependent: :destroy
end
