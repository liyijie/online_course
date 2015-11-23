class AddCommentScopeToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :comment_scope, :string
  end
end
