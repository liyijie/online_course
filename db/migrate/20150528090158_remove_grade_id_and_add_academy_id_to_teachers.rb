class RemoveGradeIdAndAddAcademyIdToTeachers < ActiveRecord::Migration
  def change
    remove_reference :teachers, :grade, index: true, foreign_key: true
    add_reference :teachers, :academy, index: true, foreign_key: true
  end
end
