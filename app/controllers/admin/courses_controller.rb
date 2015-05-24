module Admin
	class CoursesController < ApplicationController
		def index
			@courses = Course.all
		end

		def new
			@course = Course.new
		end

		def create
		end
	end
end