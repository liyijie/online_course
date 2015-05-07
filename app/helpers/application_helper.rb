module ApplicationHelper

	def get_message_class name
		bg_class ={:info => 'bg-info', :warning => 'bg-warning', :error => 'bg-danger', :notice => 'bg-primary'}
		bg_class[name]
	end
end
