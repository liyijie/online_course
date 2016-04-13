class Wechat::DiscussesController < Wechat::BaseController
	
	def index
		@talents = Specialty.enabled
	end

	def show
		
	end

	def new
		
	end

	def create
		
	end

	def learns
		@courses = Course.all
	end

	def innovations
		#找出相关话题
    @topics = Comment.find_topics_by_type params[:type], params[:page]
    #新建话题
    @discuss = Comment.new
	end
end