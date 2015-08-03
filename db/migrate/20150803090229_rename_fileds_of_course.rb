class RenameFiledsOfCourse < ActiveRecord::Migration
  def change
  	rename_column(:courses, :excellented, :city_applied)
  	rename_column(:courses, :applied, :college_applied)
  end
end
