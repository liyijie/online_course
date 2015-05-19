class TeachersController < ApplicationController
	def my_courses
		@teacher = Teacher.find_by_number(params[:number])
	end
end