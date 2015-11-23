class AddNumberToSubCourse < ActiveRecord::Migration
  def change
    add_column :sub_courses, :number, :string
  end
end
