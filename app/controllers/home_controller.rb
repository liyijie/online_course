class HomeController < ApplicationController
  def index
  	@courses = Course.limit(6)
  	@teachers = Teacher.all
  end
end
