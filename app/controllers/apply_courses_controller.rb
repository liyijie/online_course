class ApplyCoursesController < ApplicationController
	def index
		@apply_courses = Course.where(applied: true)
	end
end