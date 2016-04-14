class Wechat::DiscussesController < Wechat::BaseController
	
	# 专业人才培养校企论坛
	def index
		@talents = Specialty.enabled

		respond_to do |format|
      format.html
      format.js
    end
	end

	def show
		@topic = Comment.where(id: params[:id]).first
    #新建话题
    @discuss = Comment.new
	end

	def create
		if params[:comment][:title].present? && params[:comment][:body].present?
      usertable = current_user || current_teacher
      @discuss = Comment.new comment_params
      @discuss.usertable = usertable
      @discuss.comment_scope = "topic"

      @discuss.save

      respond_to do |format|
        format.js {render js: "location.href='#{innovations_wechat_discusses_path}'"}
      end
    else
      respond_to do |format|
        format.js {render js: "alert('请填写标题、内容');"}
      end
    end
	end

	# 课程学习讨论
	def learns
		@courses = Course.all
	end

	#创新论坛
  def innovations
    #找出相关话题
    @topics = Comment.find_topics_by_type params[:type], params[:page]
    #新建话题
    @discuss = Comment.new
    
    respond_to do |format|
      format.html
      format.js
    end
  end

	def sorts
	end

	  #回复讨论
  def reply_topic
    usertable = current_user || current_teacher
    # 保存评论
    comment = Comment.new 
    comment.usertable = usertable
    comment.comment_scope = "topic"
    comment.body = params[:comment]

    comment.save

    # 找到父评论
    parent_comment = Comment.where(id: params[:comment_id]).first
    # 为父评论添加子评论
    comment.move_to_child_of parent_comment

    @topics = Comment.find_topics_by_type params[:type], params[:page]

    if params[:is_show].present?
      respond_to do |format|
        format.js {render js: "location.href='#{wechat_discuss_path(parent_comment)}'"}
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

	private
    def comment_params
        params.require(:comment).permit(:title, :body)
    end
end