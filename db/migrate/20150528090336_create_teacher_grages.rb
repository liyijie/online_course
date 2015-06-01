class CreateTeacherGrages < ActiveRecord::Migration
  def change
    create_table :teacher_grages do |t|
      t.references :teacher, index: true, foreign_key: true
      t.references :grade, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
