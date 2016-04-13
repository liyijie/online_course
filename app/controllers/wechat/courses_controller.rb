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
  end

  def sub_course
    @course = Course.find_by(number: params[:id])
    #教学课件子课程
    @jxtj_sub_courses = @course.sub_courses.enabled.undeleted.where(category_id: Category.find_by(name: "教学课件").id) if Category.find_by(name: "教学课件")
    #教学视频子课程
    @jxsp_sub_courses = @course.sub_courses.enabled.where(category_id: Category.find_by(name: "教学视频").id) if Category.find_by(name: "教学视频")
    #典型案例子课程
    @dxal_sub_courses = @course.sub_courses.enabled.where(category_id: Category.find_by(name: "典型案例").id) if Category.find_by(name: "典型案例")
    #学生作品子课程
    @xszp_sub_courses = @course.sub_courses.enabled.where(category_id: Category.find_by(name: "学生作品").id) if Category.find_by(name: "学生作品")
    #自主学习子课程
    @zzxx_sub_courses = @course.sub_courses.enabled.where(category_id: Category.find_by(name: "自主学习资源").id) if Category.find_by(name: "自主学习资源")
    #读取教师课程
    @teacher_courses = @course.teacher_courses
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
