class AddTagToSubCourse < ActiveRecord::Migration
  def change
    add_column :sub_courses, :tag, :string
  end
end
