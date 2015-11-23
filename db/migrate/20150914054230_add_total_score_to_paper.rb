class AddTotalScoreToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :total_score, :integer
  end
end
