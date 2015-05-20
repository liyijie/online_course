class TeachersController < ApplicationController
	before_action :authenticate_teacher!
	#我的课程
	def my_courses
	end

  #我的班级
	def my_grades
	end

  #教师介绍
	def my_info
	end

	#我的账户
	def my_account
	end

  #上传课件
	def upload_course_ware
	end

  #讨论中心
	def discuss_center
	end

  #我的问答
	def my_faqs
	end
end