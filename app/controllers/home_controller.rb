class HomeController < ApplicationController
  def index
  	#读取6个课程
  	@courses = Course.limit(6)

  	#读取拥有课程内容的学院，限制9个
  	academy_arr = Course.pluck(:academy_id)
  	@academies = Academy.where({id: academy_arr}).limit(9)

    #读取5个老师
  	@teachers = Teacher.limit(5)
  end

  def select_courses
    if params[:academy_id]
      academy = Academy.find_by(id: params[:academy_id])
      @courses = academy.courses.limit(6)
    elsif
      @courses = Course.limit(6)
    end
  	respond_to do |format|
  		format.js
  	end
  end
end
