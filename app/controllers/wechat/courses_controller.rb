class Wechat::CoursesController < Wechat::BaseController
  before_action :set_course_number
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
  end

  def sub_course
    @course = Course.find_by(number: params[:id])

    @categories = Category.all
    @category_arr = Category.pluck(:id)
    #专业人才培养方案子课程
    @zyrc_sub_courses = @course.sub_courses.enabled.zyrc.where({category_id: @category_arr})
    #课程标准子课程
    @kcbz_sub_courses = @course.sub_courses.enabled.kcbz.where({category_id: @category_arr})
    #电子教材子课程
    @dzjc_sub_courses = @course.sub_courses.enabled.dzjc.where({category_id: @category_arr})
    #电子教案子课程
    @dzja_sub_courses = @course.sub_courses.enabled.dzja.where({category_id: @category_arr})
    #考核标准子课程
    @khbz_sub_courses = @course.sub_courses.enabled.khbz.where({category_id: @category_arr})

    #课程子栏目
    @sub_courses_info = @course.sub_courses.enabled.where(category_id: Category.find_by(name: params[:title]).id) if Category.find_by(name: params[:title])
    @sub_course_name = params[:title]
  end

  def after_class_exams
    @course = Course.find_by(number: params[:id])
    @sub_courses = @course.sub_courses.undeleted
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

  protected
  def set_course_number
    @course = Course.find_by(number: params[:id])
  end
end
