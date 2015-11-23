class AddCountInfoToExam < ActiveRecord::Migration
  def change
    add_column :exams, :correct_count, :integer
    add_column :exams, :all_count, :integer
  end
end
