class AddObjectiveScoreToUserPaper < ActiveRecord::Migration
  def change
    add_column :user_papers, :objective_total, :integer, default: 0
  end
end
