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
		  if Question.where(sub_course_id: sub_course.id).import(params[:file])
		    flash.now[:notice] = "试题导入成功!"
		  else
		  	flash.now[:notice] = "试题导入失败!"
		  end
		  redirect_to admin_course_sub_course_questions_url(course.id, sub_course.id)
		end

		def destroy
			@question = Question.find(params[:id])
			@question.destroy
			redirect_to admin_course_sub_course_questions_path(course_id: params[:course_id], sub_course_id: params[:sub_course_id])
		end
		# def destroy
  #     #@academy.destroy
  #     return redirect_to admin_course_sub_course_questions_url(course.id, sub_course.id)
  #   end
	end
end