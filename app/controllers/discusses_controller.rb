class DiscussesController < ApplicationController
  before_action :authenticate_user_or_teacher, only: [:create]

  def index
    @academies = Academy.all
    @discuss = Comment.new
  end

  def show

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
        format.js {render js: "alert('请填写好标题、内容');"}
      end
    end
  end


  private
    def comment_params
        params.require(:comment).permit(:title, :body)
    end

end
