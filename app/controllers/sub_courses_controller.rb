class SubCoursesController < ApplicationController
	def show
	end

  #课件下载
	def download
		@sub_course = SubCourse.find_by(number: params[:number])
		send_file @sub_course.attachment.content.path,
		          type: @sub_course.attachment.content.content_type,
		          x_sendfile: true
	end
end