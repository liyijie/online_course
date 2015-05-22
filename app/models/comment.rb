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

# comment_scope: discuss表示我的评论，question表示我的提问，answer表示我的提问的回答

class Comment < ActiveRecord::Base
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

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
    Comment.where(parent_id:nil, usertable: usertable, comment_scope: comment_scope).order("created_at DESC")
  end
end
