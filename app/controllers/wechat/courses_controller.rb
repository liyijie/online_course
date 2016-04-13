class Wechat::CoursesController < Wechat::BaseController
  def index
    @academies = Academy.all
    @courses = Course.undeleted.search_courses(params)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @course = Course.find_by(number: params[:id])
    pp @courses
    pp "---------------"
  end

  #课程的收藏或者取消收藏
  def course_collect
    collect_sucess, @collect = Course.course_collect_or_praise params[:course_id], current_user, "collect"
  
    if collect_sucess
        respond_to do |format|
        format.js {""}
      end
    else
      respond_to do |format|
          format.js { render js: "alert('学生登录才可以收藏');" }
        end
    end 
  end
end
