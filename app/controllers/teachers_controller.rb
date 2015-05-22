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

  #成绩查询
	def my_score
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

  #修改个人信息
	def update
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
end