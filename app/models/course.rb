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

	#课程收藏或取消收藏
	#参数：课程：couorse_id,当前登录用户
	#返回值：第一个返回值表示操作是否成功，true，false
	#第二个返回值表示当前是什么操作
	def self.course_collect couorse_id, current_user

		course = Course.where(id: couorse_id).first

		return false if course.blank? || current_user.blank?

		if current_user.voted_up_on? course, vote_scope: :collect
			#已经收藏过时取消收藏
			course.downvote_from current_user, vote_scope: :collect
			return true,"collect"
		else
			#未收藏则收藏
			course.like_by current_user, vote_scope: :collect
			return true,"uncollect"
		end
	end
end
