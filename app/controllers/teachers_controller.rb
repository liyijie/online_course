class TeachersController < ApplicationController
	before_action :authenticate_teacher!, except: [:index, :show]

	#教师风采
	def index
		@teachers = Teacher.page(params[:page]).per(20)
	end

	#教师展示
	def show
		@teacher = Teacher.find_by(number: params[:number])
	end

	#我的课程
	def my_courses
		@courses = Course.joins(:teacher_courses).where(teacher_courses: {teacher_id: current_teacher.id})
	end

	def get_sub_course
		course = Course.where(number: params[:id]).first
		@sub_courses = course.try(:sub_courses)
		respond_to do |format|
			format.js
		end
	end

  #我的班级
	def my_grades
	end

  #教师介绍
	def my_info
	end

  #成绩查询
	def my_score
		@academies = Academy.all.pluck(:id, :name)
	end

	#成绩查询----选择班级
	def select_grade
		@grades = Grade.joins(:specialty).where(specialties: {academy_id: params[:academy_id]}).pluck("grades.id","grades.name")
	end

	#成绩查询----选择课程
	def select_course
		@courses = Course.where(academy_id: params[:academy_id]).pluck(:id, :name)
	end

	#成绩查询----显示查询结果
	def show_score
		
	end

	#我的账户
	def my_account
	
	end

  #上传课件
	def upload_course_ware
	end

  #讨论中心
	def discuss_center
		@comments = Comment.find_root_comments_by_usertable(current_teacher, :discuss).page(params[:page])
	end

  #我的提问
	def my_questions
		@question_comments = Comment.find_root_comments_by_usertable(current_teacher, :answer).page(params[:page])
	end

  #我的回答
	def my_answers
		@answer_comments = Comment.find_answer_by_usertable(current_teacher).page(params[:page])
	end

  #修改个人信息
	def update
		if current_teacher.update(teacher_params)
			current_teacher.image = Image.new
			current_teacher.image.avatar = params[:teacher][:avatar] if params[:teacher][:avatar].present?
			current_teacher.image.save
			flash.now[:notice] = "信息修改成功"
			redirect_to my_account_teachers_url
		else
			p current_teacher.errors
			flash.now[:notice] = "信息修改失败"
			redirect_to my_account_teachers_url
		end
	end

  #修改密码
	def update_password
		if params[:teacher][:password] != current_teacher.password
			return render js: "$('.error-info').html('*原始密码不正确！');"
			#return render text: '原始密码不正确'
		end
		if params[:teacher][:new_password].blank?
			return render js: "$('.error-info').html('*新密码不能为空！');"
			#return render text: '新密码不能为空'
		end
		if params[:teacher][:new_password] != params[:teacher][:confirm_new_password]
			return render js: "$('.error-info').html('*两次输入不一致！');"
			#return render text: '两次输入不一致'
		end
		current_teacher.update_attributes(password: params[:teacher][:new_password])
		flash.now[:notice] = "密码修改成功"
		return redirect_to my_account_teachers_url
		respond_to do |format|
			format.js
		end
	end

	private
	def teacher_params
		params.require(:teacher).permit(:phone, :username, :number, :name, :avatar,
			                              :birthday, :tec_position, :email, :qualification,
			                              :fax, :final_education, :final_degree, :tec_expertise,
			                              :resume, :tec_situation, :tec_service, :deleted_at,
			                              :sex, :grade_id, :signature)
	end
end