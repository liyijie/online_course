class RenameTeacherGrageToTeacherGrade < ActiveRecord::Migration
  def change
    rename_table :teacher_grages, :teacher_grades
  end
end
