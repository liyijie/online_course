# == Schema Information
#
# Table name: courses
#
#  id              :integer          not null, primary key
#  number          :string(255)
#  name            :string(255)
#  description     :text(65535)
#  content         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  academy_id      :integer
#  scope           :integer          default(1)
#  city_applied    :boolean          default(FALSE)
#  college_applied :boolean          default(FALSE)
#  manager_id      :integer
#  specialty_id    :integer
#  applied_date    :string(255)
#

class Course < ActiveRecord::Base
	#评论回复
	acts_as_commentable
	#关注、喜欢、收藏
	acts_as_votable

	acts_as_commentable
	has_one :image, as: :imageable, dependent: :destroy
	has_one :attachment, as: :attachmentable, dependent: :destroy
	has_many :sub_courses, dependent: :destroy
	belongs_to :academy
	belongs_to :specialty
	has_many :teacher_courses, dependent: :destroy
	has_many :teachers, through: :teacher_courses
	belongs_to :manager, class_name: "Teacher",  foreign_key: "manager_id"

	#创建course生成编号
	before_create do
		self.number = NumberHelper.random_course_number
	end

  enum category_scopes: {
  	'市级精品课程': 1,
  	'校级精品课程': 2
  }
	#课程收藏(赞)或取消收藏（取消赞）
	#参数：课程：couorse_id,当前登录用户
	#返回值：第一个返回值表示操作是否成功，true，false
	#第二个返回值表示当前是什么操作
	def self.course_collect_or_praise couorse_id, current_user, vote_scope
		course = Course.where(id: couorse_id).first

		return false if course.blank? || current_user.blank?

		if current_user.voted_up_on? course, vote_scope: vote_scope.to_sym
			#已经收藏（赞）过时取消收藏（取消赞）
			course.downvote_from current_user, vote_scope: vote_scope.to_sym
			return true, vote_scope
		else
			#未收藏（赞）则收藏（赞）
			course.like_by current_user, vote_scope: vote_scope.to_sym
			return true,"un#{vote_scope}"
		end
	end

	def deleted?
		self.deleted_at.present? ? true : false
	end

	scope :undeleted, -> {where("deleted_at is null")}
	scope :bedeleted, -> {where("deleted_at is not null")}

	def self.search_courses params
		conn = [['1=1']]
		if params[:academy_id].present?
			conn[0] << 'academy_id = ?'
			conn << params[:academy_id]
		end

		if params[:scope].present?
			if params[:scope] == "1"
				conn[0] << 'city_applied = true'
			elsif params[:scope] == "2"
				conn[0] << 'city_applied = false AND college_applied = true'
			end
		end
		conn[0] = conn[0].join(' and ')

		if params[:type].present?
			Course.where(conn).order("created_at DESC")
		else
			Course.where(conn)
		end

	end
end
