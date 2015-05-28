# == Schema Information
#
# Table name: sub_courses
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  name       :string(255)
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  number     :string(255)
#

class SubCourse < ActiveRecord::Base
  acts_as_commentable
  belongs_to :course
  has_one :attachment
  has_many :questions, dependent: :destroy

  #创建sub_course生成编号
	before_create do
		self.number = NumberHelper.random_course_number
	end

  #判断附件格式是否是视频类
	def regex_video
		self.attachment && self.attachment.content_file_name && self.attachment.content.content_type =~ /video(.*)/
	end

  #判断附件格式是否是文档类
	def regex_res
		self.attachment && self.attachment.content_file_name && self.attachment.content.content_type =~ /application(.*)/
	end

  #计算附件大小
	def count_file_size
		size = ""
		if self.attachment && self.attachment.content_file_size
			if (self.attachment.content_file_size / 1048576) < 1
				size = (self.attachment.content_file_size / 1024).to_s + "KB"
			else
				size = (self.attachment.content_file_size / 1048576).to_s + "MB"
			end
		end
		size
	end


  #发布评论并返回新的评论一览
  #参数，user:登录的用户，params：提交的参数
  def self.save_comment_return_comments user, params
    sub_course = SubCourse.where(number: params[:number]).first
    if sub_course.blank?
      nil
    else
       #新评论保存
      if user.present? && params[:comment].present? && params[:comment_scope]
        comment = Comment.build_from sub_course, user, params[:comment], params[:comment_scope]
        comment.save
      end
      
      #返回所有评论
      sub_course.root_comments.where(comment_scope:  params[:comment_scope]).order("created_at DESC").page(params[:page])
    end
  end


  #回复评论后返回新的评论一览
  def self.reply_comment_returns_comments user,params
    sub_course = SubCourse.where(number: params[:number]).first
    parent_comment = Comment.where(id: params[:comment_id]).first

    #保存新的评论
    if sub_course.present? && parent_comment.present?
      comment = Comment.build_from sub_course, user, params[:comment], params[:comment_scope]
      comment.save
      comment.move_to_child_of parent_comment
    end

    #返回所有评论
    sub_course.root_comments.where(comment_scope:  params[:comment_scope]).order("created_at DESC").page(params[:page])
  end
end