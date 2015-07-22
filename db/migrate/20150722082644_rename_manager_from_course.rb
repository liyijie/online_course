class RenameManagerFromCourse < ActiveRecord::Migration
  def change
  	rename_column :courses, :manager, :manager_id
  end
end
