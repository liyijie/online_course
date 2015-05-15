class RenameAcademyIdToSpecialtyIdOnGrade < ActiveRecord::Migration
  def change
  	rename_column :grades, :academy_id, :specialty_id
  end
end
