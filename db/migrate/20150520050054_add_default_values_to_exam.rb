class AddDefaultValuesToExam < ActiveRecord::Migration
  def change
  	change_column_default(:exams, :correct_count, 0)
  	change_column_default(:exams, :all_count, 0)
  end
end
