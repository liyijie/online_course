class DiscussesController < ApplicationController
  before_action :authenticate_user_or_teacher, only: [:create]

  def index
    #找出相关话题
    @topics = Comment.find_topics_by_type params[:type], params[:page]

    #新建话题
    @discuss = Comment.new

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
        format.js {render js: "location.href='#{discusses_path}'"}
      end
    else
      respond_to do |format|
        format.js {render js: "alert('请填写标题、内容');"}
      end
    end
  end


  private
    def comment_params
        params.require(:comment).permit(:title, :body)
    end

end
