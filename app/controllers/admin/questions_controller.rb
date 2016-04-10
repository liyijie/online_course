module Admin
	class QuestionsController < ApplicationController
		load_and_authorize_resource
		def index
			@course = Course.find(params[:course_id])
			@sub_course = SubCourse.find(params[:sub_course_id])
			@questions = @sub_course.questions.page(params[:page]).per(10)
		end

		def import
			course = Course.find(params[:course_id])
			sub_course = SubCourse.find(params[:sub_course_id])
			errors = Question.where(sub_course_id: sub_course.id).import(params[:file])

		  if errors.blank?
		    flash[:notice] = "试题导入成功!"
		  else
		  	flash[:notice] = "试题导入失败!#{errors.first}"
		  end
		  redirect_to admin_course_sub_course_questions_url(course.id, sub_course.id)
		end

		# def destroy
		# 	@question = Question.find(params[:id])
		# 	@question.destroy
		# 	redirect_to admin_course_sub_course_questions_path(course_id: params[:course_id], sub_course_id: params[:sub_course_id])
		# end

		def clear
			@sub_course = SubCourse.find(params[:sub_course_id]).questions.destroy_all
			if @sub_course
				flash[:error] = "删除成功"
				redirect_to admin_course_sub_course_questions_path(course_id: params[:course_id], sub_course_id: params[:sub_course_id])
			else
				flash[:error] = "清空失败"
				redirect_to admin_course_sub_course_questions_path(course_id: params[:course_id], sub_course_id: params[:sub_course_id])
			end
    end
	end
end