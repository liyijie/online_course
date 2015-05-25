class HomeController < ApplicationController
  def index
  	@courses = Course.limit(6)
  	@teachers = Teacher.limit(5)
  end
end
