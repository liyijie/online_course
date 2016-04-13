class Wechat::DiscussesController < Wechat::BaseController
	
	def index
		@talents = Specialty.enabled
	end

	def show
		
	end
end