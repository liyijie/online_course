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
		menu << content_tag('li', link_to('精品课程', courses_path), class: ["courses","sub_courses"].include?(controller.controller_path) && ["index"].include?(controller.action_name) ? 'active' : '')
		menu << content_tag('li', link_to('精品课程申报', apply_courses_path), class: ["apply_courses"].include?(controller.controller_path) && ["index"].include?(controller.action_name) ? 'active' : '')
		menu << content_tag('li', link_to('教师风采', teachers_path), 
			class: (controller.controller_path == 'teachers' and (controller.action_name=="index" || controller.action_name=="show")) ? 'active' : '' )
			menu << content_tag('li', link_to('学习中心', courses_learning_center_path), class: (controller.controller_path == 'courses' && controller.action_name == "learning_center") ? 'active' : '')
		menu << content_tag('li', link_to('讨论中心', discusses_path), class: controller.controller_path == 'discusses' ? 'active' : '')
		menu << content_tag('li', link_to('测试中心', papers_path), class: controller.controller_path == 'user_papers' || controller.controller_path == 'papers' || controller.controller_path == 'answers' ? 'active' : '')
		unless teacher_signed_in?
			menu << content_tag('li', link_to('个人中心', my_courses_user_index_path) , 
				class: (controller.controller_path == 'user' or controller.controller_path == 'devise/registrations') ? 'active' : '')
		else
			menu << content_tag('li', link_to('个人中心', my_courses_teachers_path) , 
				class: (((controller.controller_path == 'teachers' && controller.action_name != "show") or controller.controller_path == 'devise/registrations') and controller.action_name!="index") ? 'active' : '')
		end

		menu.join.html_safe
	end


	#回显选中题
	def is_selected? index, answer
		answer_index = {1 => "A", 2 => "B", 3 => "C", 4 => "D", 5 => "E"}
		answer_index[index + 1].try(:strip) == answer.try(:strip)
	end

	def select_item index
		answer_index = {1 => "A", 2 => "B", 3 => "C", 4 => "D", 5 => "E"}
		answer_index[index + 1]
	end
end
