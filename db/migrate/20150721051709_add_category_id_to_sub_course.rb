class AddCategoryIdToSubCourse < ActiveRecord::Migration
  def change
    add_column :sub_courses, :category_id, :integer
  end
end
