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
  	menu << content_tag('li', link_to('精品课程', courses_path), class: ["courses","sub_courses"].include?(controller.controller_path) ? 'active' : '')
  	menu << content_tag('li', link_to('教师风采', teachers_path), 
      class: (controller.controller_path == 'teachers' and (controller.action_name=="index" || controller.action_name=="show")) ? 'active' : '' )
    menu << content_tag('li', link_to('讨论中心', discusses_path), class: controller.controller_path == 'discusses' ? 'active' : '')
    menu << content_tag('li', link_to('考试中心', exams_path), class: controller.controller_path == 'exams' && controller.action_name=="index" ? 'active' : '')
  	unless teacher_signed_in? 
  		menu << content_tag('li', link_to('个人中心', my_courses_user_index_path) , 
        class: (controller.controller_path == 'user' or controller.controller_path == 'devise/registrations') ? 'active' : '')
    else
      menu << content_tag('li', link_to('个人中心', my_courses_teachers_path) , 
        class: (((controller.controller_path == 'teachers' && controller.action_name != "show") or controller.controller_path == 'devise/registrations') and controller.action_name!="index") ? 'active' : '')
  	end
  	
  	menu.join.html_safe
  end

end
