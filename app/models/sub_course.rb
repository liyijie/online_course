# == Schema Information
#
# Table name: sub_courses
#
#  id          :integer          not null, primary key
#  course_id   :integer
#  name        :string(255)
#  content     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  number      :string(255)
#  category_id :integer
#  position    :integer          default(0)
#

class SubCourse < ActiveRecord::Base
  acts_as_commentable
  acts_as_votable
  belongs_to :course
  belongs_to :category
  has_one :attachment, as: :attachmentable, dependent: :destroy
  has_many :questions, dependent: :destroy
  acts_as_list
  default_scope {order('position desc')}

  #创建sub_course生成编号
	before_create do
		self.number = NumberHelper.random_course_number
	end

  #标签选项
  enum tag: {
    zyrc: '0',
    kcbz: '1',
    dzjc: '2',
    dzja: '3',
    khbz: '3',
  }

  TAGS = {
    zyrc: '专业人才培养方案',
    kcbz: '课程标准',
    dzjc: '电子教材',
    dzja: '电子教案',
    khbz: '考核标准',
  }

  #判断附件格式是否是视频类
	def regex_video
		self.attachment && self.attachment.content_file_name && self.attachment.content.content_type =~ /^video/
	end

  #判断附件格式是否是文档类
	def regex_res
		self.attachment && self.attachment.content_file_name && self.attachment.content.content_type =~ /^application/
	end

  def deleted?
    self.deleted_at.present? ? true : false
  end

  scope :undeleted, -> {where("deleted_at is null")}
  scope :bedeleted, -> {where("deleted_at is not null")}

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

  #是否收藏
  def is_collect?
    self.get_likes(vote_scope: :collect).size > 0
  end

  #是否喜欢
  def is_praise?
    self.get_likes(vote_scope: :praise).size > 0
  end 

  #收藏或者喜欢子课程
  #参数：user,收藏的用户；vote_scope，收藏还是喜欢
  #返回值：第一个收藏是否成功，第二个这次是收藏还是取消收藏
  def self.collect_or_praise user,vote_scope,sub_course_id
    sub_course = SubCourse.where(id: sub_course_id).first

    return false if sub_course.blank? || user.blank? || !(['collect','praise'].include? (vote_scope))

    if user.voted_up_on? sub_course, vote_scope: vote_scope.to_sym
      #已经收藏（赞）过时取消收藏（取消赞）
      sub_course.downvote_from user, vote_scope: vote_scope.to_sym
      return true, false
    else
      #未收藏（赞）则收藏（赞）
      sub_course.like_by user, vote_scope: vote_scope.to_sym
      return true,true
    end
  end 
end
