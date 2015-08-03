class AddPositionToSubCourse < ActiveRecord::Migration
  def change
    add_column :sub_courses, :position, :integer, default: 0
  end
end
