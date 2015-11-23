class AddEvaluatedToUserPaper < ActiveRecord::Migration
  def change
    add_column :user_papers, :evaluated, :boolean, default: false
    change_column :user_papers, :total_score, :integer, default: 0
  end
end
