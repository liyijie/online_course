class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :user, index: true, foreign_key: true
      t.references :sub_course, index: true, foreign_key: true
      t.integer :total_score

      t.timestamps null: false
    end
  end
end
