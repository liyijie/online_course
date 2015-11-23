class TeachersController < ApplicationController
	before_action :authenticate_teacher!, except: [:index, :show]

	#教师风采
	def index
		@academies = Academy.all
		unless params[:academy_id].blank?
		  @teachers = Teacher.where(academy_id: params[:academy_id]).joins(:image).where("images.avatar_content_type IS NOT NULL")
		                    .page(params[:page]).per(20)
		else
			@teachers = Teacher.joins(:image).where("images.avatar_content_type IS NOT NULL")
		                    .page(params[:page]).per(20)
		end
	end

	#教师展示
	def show
		@teacher = Teacher.find_by(number: params[:number])
	end

	#我的课程
	def my_courses
		@courses = Course.joins(:teacher_courses).where(teacher_courses: {teacher_id: current_teacher.id})
    #@sub_courses = SubCourse.where({course_id: @courses.pluck(:id)})
	end

	#取得子课程
	def get_sub_course
		course = Course.where(number: params[:id]).first
		@sub_courses = course.try(:sub_courses)
		respond_to do |format|
			format.js
		end
	end

	#上传课件
	def upload_attachment
		sub_course = SubCourse.where(number: params[:sub_course_number]).first
		if sub_course.blank?
			respond_to do |format|
				format.js {render js: "alert('上传失败');"}
			end
		else
			sub_course.attachment = Attachment.new if sub_course.attachment.blank?
			if sub_course.attachment.update(content: params[:attachment])
				#上传成功
				@sub_courses = Course.where(id: sub_course.course_id).first.sub_courses
				respond_to do |format|
					format.js
				end
			else
				respond_to do |format|
					format.js {render js: "alert('上传失败');"}
				end
			end
		end
	end

  #导入试题
	def import_question
		@sub_course = SubCourse.find_by(number: params[:sub_course_number])
		@questions = @sub_course.questions.page(params[:page]).per(15)
	end

	def import
		sub_course = SubCourse.find_by(number: params[:sub_course_number])
	  if Question.where(sub_course_id: sub_course.id).import(params[:file])
	    flash.now[:notice] = "试题导入成功!"
	    return redirect_to import_question_teachers_path(sub_course_number: sub_course.number)
	  else
	  	flash.now[:notice] = "试题导入失败!"
	  	return redirect_to import_question_teachers_path(sub_course_number: sub_course.number)
	  end
	end

  #我的班级
	def my_grades
		@grades = Grade.joins(:teacher_grades).where(teacher_grades: { teacher_id: current_teacher.id })
	end

	def grade_students
		@grade = Grade.where(id: params[:id]).first
	end

  #教师介绍
	def my_info
	end

  #成绩查询
	def my_score
		@specialties = Specialty.all.pluck(:id, :name)
	end

	#成绩查询----选择班级
	def select_grade
		@grades = Grade.joins(:specialty).where(specialties: {id: params[:specialty_id]}).pluck("grades.id","grades.name")
	end

	#成绩查询----选择课程
	def select_course
		specialtie = Specialty.where(id: params[:specialty_id]).first
		@courses = Course.where(academy_id: specialtie.academy_id).pluck(:id, :name)
	end

	# 成绩查询----选择课程
	def select_exam
		course = Course.where(id: params[:course_id]).first
		@sub_courses = course.sub_courses.pluck(:id, :name) if course.present?
	end	

	# 成绩查询----显示查询结果
	def show_score
		@specialtie = Specialty.where(id: params[:specialty_id]).first
		@sub_course = SubCourse.where(id: params[:sub_course_id]).first
		@grades = Grade.where(id: params[:grade_ids].split(',').uniq)
		@grades.each{ |grade| grade.exam_result!(@sub_course) }
	end

	# 成绩查询----显示班级考试结果统计
	def show_grade_score
		@grades = Grade.where(id: params[:grade_ids].split(',').uniq)
		@sub_course = SubCourse.where(id: params[:sub_course_id]).first
		@questions = @sub_course.questions
		@exam_analyze = ExamItem.exam_analyze(@grades, @sub_course)
	end

	# 成绩导出
	def export
		grades = Grade.where(id: params[:grade_ids].split(',').uniq)
		sub_course = SubCourse.where(id: params[:sub_course_id]).first
		specialtie = Specialty.where(id: params[:specialty_id]).first
		filename = URI.encode("#{specialtie.name}_#{sub_course.name}.xls")
		send_data( 
						Grade.export(grades, sub_course),
						type: "text/excel;charset=utf-8; header=present",
						filename: filename
					)
	end

	# 我的账户
	def my_account
		
	end

  # 讨论中心
	def discuss_center
		@comments = Comment.find_root_comments_by_usertable(current_teacher, :discuss).page(params[:page])
	end

  # 我的提问
	def my_questions
		@question_comments = Comment.find_root_comments_by_usertable(current_teacher, :answer).page(params[:page])
	end

  # 我的回答
	def my_answers
		@answer_comments = Comment.find_answer_by_usertable(current_teacher).page(params[:page])
	end

  # 修改个人信息
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

  # 修改密码
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
		params.require(:teacher).permit(:number, :phone, :username, :number, :name, :avatar,
			                              :birthday, :tec_position, :email, :qualification,
			                              :fax, :final_education, :final_degree, :tec_expertise,
			                              :resume, :tec_situation, :tec_service, :deleted_at,
			                              :sex, :grade_id, :signature, :academy_id)
	end
end