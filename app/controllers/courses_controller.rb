class CoursesController < ApplicationController
	before_action :authenticate_user! , only: [:course_collect, :course_praise] , if: "!teacher_signed_in?"

	def index
		@academies = Academy.all
		@courses = Course.undeleted.search_courses(params).page(params[:page]).per(9)

		respond_to do |format|
	  	format.html
	  	format.js
    end
	end

  #学习中心
	def learning_center
		@academies = Academy.all
		@courses = Course.undeleted.search_courses(params).page(params[:page]).per(9)

		respond_to do |format|
	  	format.html
	  	format.js
    end
	end

	def show
		@course = Course.find_by(number: params[:number])
		#读取子课程分类
		@categories = Category.all
    @category_arr = Category.pluck(:id)
		#专业人才培养方案子课程
		@zyrc_sub_courses = @course.sub_courses.zyrc.where({category_id: @category_arr})
		#课程标准子课程
		@kcbz_sub_courses = @course.sub_courses.kcbz.where({category_id: @category_arr})
		#电子教材子课程
		@dzjc_sub_courses = @course.sub_courses.dzjc.where({category_id: @category_arr})
		#电子教案子课程
		@dzja_sub_courses = @course.sub_courses.dzja.where({category_id: @category_arr})
		#考核标准子课程
		@khbz_sub_courses = @course.sub_courses.khbz.where({category_id: @category_arr})

    #教学条件子课程
    @jxtj_sub_courses = @course.sub_courses.undeleted.where(category_id: Category.find_by(name: "教学课件").id) if Category.find_by(name: "教学课件")
    #教学视频子课程
    @jxsp_sub_courses = @course.sub_courses.where(category_id: Category.find_by(name: "教学视频").id) if Category.find_by(name: "教学视频")
    #典型案例子课程
    @dxal_sub_courses = @course.sub_courses.where(category_id: Category.find_by(name: "典型案例").id) if Category.find_by(name: "典型案例")
    #学生作品子课程
    @xszp_sub_courses = @course.sub_courses.where(category_id: Category.find_by(name: "学生作品").id) if Category.find_by(name: "学生作品")
    #自主学习子课程
    @zzxx_sub_courses = @course.sub_courses.where(category_id: Category.find_by(name: "自主学习资源").id) if Category.find_by(name: "自主学习资源")
		#读取教师课程
		@teacher_courses = @course.teacher_courses
	end

	def create
		@course = Course.new(course_params)
		@course.image = Image.new
		@course.image.avatar = params[:course][:image]
		if @course.save
			flash.now[:notice] = "课程创建成功"
			return redirect_to upload_course_ware_teachers_path
		else
			flash.now[:notice] = "课程创建失败"
			return redirect_to upload_course_ware_teachers_path
		end
	end

  #课后作业
	def after_class
		@course = Course.find_by(number: params[:number])
		@teacher_courses = @course.teacher_courses
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

	#课程点赞或者取消赞
	def course_praise
		praise_sucess, @praise = Course.course_collect_or_praise params[:course_id], current_user, "praise"
	
		if praise_sucess
	  		respond_to do |format|
	  		format.js {""}
    	end
		else
	 		respond_to do |format|
	  			format.js { render js: "alert('学生登录才可以收藏');" }
    		end
		end 
	end

	private
	  def course_params
	  	params.require(:course).permit(:number, :name, :description, :manager_id)
	  end

end