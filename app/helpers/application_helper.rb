module ApplicationHelper

  def get_message_class name
	bg_class ={:info => 'bg-info', :warning => 'bg-warning', :error => 'bg-danger', :notice => 'bg-success'}
	bg_class[name]
  end



  #导航栏菜单生成，根据controller设置选中的菜单
  #2015/05/16 by fw
  def show_menu
	  menu = Array.new
  	#controller.action_name
  	menu << content_tag('li', link_to('首页', root_path), class: controller.controller_path == 'home' ? 'active' : '')
  	#menu << content_tag('li', link_to('课程中心', courses_path), class: ["courses","exams"].include?(controller.controller_path) ? 'active' : '')
  	menu << content_tag('li', link_to('教师风采', teachers_path), class: controller.controller_path == 'xxxx' ? 'active' : '' )
  	if user_signed_in?
  		menu << content_tag('li', link_to('个人中心', my_courses_user_index_path) , class: controller.controller_path == 'user' ? 'active' : '')
  	end

  	if teacher_signed_in?
  		menu << content_tag('li', link_to('个人中心', my_courses_teachers_path) , class: controller.controller_path == 'teachers' ? 'active' : '')
  	end
  	menu.join.html_safe
  end

end
