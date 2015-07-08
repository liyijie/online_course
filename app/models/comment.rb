# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  title            :string(255)
#  body             :text(65535)
#  subject          :string(255)
#  usertable_id     :integer          not null
#  usertable_type   :string(255)      not null
#  parent_id        :integer
#  lft              :integer
#  rgt              :integer
#  created_at       :datetime
#  updated_at       :datetime
#  comment_scope    :string(255)
#

# comment_scope: discuss表示我的评论，answer表示我的问答，topic讨论中心的话题

class Comment < ActiveRecord::Base
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  acts_as_votable

  validates :body, :presence => true
  validates :usertable, :presence => true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_votable

  belongs_to :commentable, :polymorphic => true

  # NOTE: Comments belong to a user
  #edit by fw 2015/05/20  学生和教师都需可以评论
  #belongs_to :user
  belongs_to :usertable, :polymorphic => true
  #edit by fw 2015/05/20  学生和教师都需可以评论

  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  #edit by fw 2015/05/20  学生和教师都需可以评论
  # def self.build_from(obj, user_id, comment)
  #   new \
  #     :commentable => obj,
  #     :body        => comment,
  #     :user_id  => user_id
  # end
  def self.build_from(obj, usertable, comment, comment_scope)
    new \
      commentable: obj,
      body: comment,
      usertable: usertable,
      comment_scope: comment_scope
  end
  #edit by fw 2015/05/20  学生和教师都需可以评论

  #helper method to check if a comment has children
  def has_children?
    self.children.any?
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  #edit by fw 2015/05/20  学生和教师都需可以评论
  # scope :find_comments_by_user, lambda { |user|
  #   where(:user_id => user.id).order('created_at DESC')
  # }
  scope :find_comments_by_user, lambda { |user|
    where(usertable: user).order('created_at DESC')
  }
  #edit by fw 2015/05/20  学生和教师都需可以评论

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(commentable_type: commentable_str.to_s, commentable_id: commentable_id).order('created_at DESC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end

  #取得用户的评论或者提问
  #参数：评论的发布者，comment_scope查找评论还是问题
  #返回：当前发布者的评论或者问题
  def self.find_root_comments_by_usertable usertable, comment_scope
    Comment.where(parent_id: nil, usertable: usertable, comment_scope: comment_scope).order("created_at DESC")
  end

  #获取用户对提问的回答
  def self.find_answer_by_usertable usertable
    #Comment.where(usertable: usertable, comment_scope: :answer).order("created_at DESC")
    Comment.where("usertable_id = ? and usertable_type =? and comment_scope = ? and parent_id is not null",usertable.id,usertable.class,"answer").order("created_at DESC")
  end

  #取得comment的父节点
  def parent
    Comment.find self.parent_id if self.parent_id.present?
  end

  #评论点赞
  #参数：点赞用户
  #返回值：true，点赞；false，取消点赞
  def comment_praise user
    if user.voted_up_on? self, vote_scope: :praise
      self.downvote_from user, vote_scope: :praise
      return false
    else
      self.like_by user, vote_scope: :praise
      return true
    end
  end

  #讨论中心取得话题
  def self.find_topics_by_type type, page
    case type
    when "new"
      Comment.includes(:usertable).where("comment_scope = 'topic' and parent_id is null").order("created_at DESC").page(page)
    when "hot"
      Comment.includes(:usertable).where("comment_scope = 'topic' and parent_id is null").order("(select count(*) from comments cs where parent_id = comments.id) DESC").page(page)
    when "wait"
      Comment.includes(:usertable).where("comment_scope = 'topic' and parent_id is null and (select count(*) from comments cs where parent_id = comments.id) = 0").order("created_at DESC").page(page)
    else
      Comment.includes(:usertable).where("comment_scope = 'topic' and parent_id is null").order("created_at DESC").page(page)
    end
      
  end

end
