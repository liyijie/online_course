class CreateSubCourses < ActiveRecord::Migration
  def change
    create_table :sub_courses do |t|
      t.references :course, index: true, foreign_key: true
      t.string :name
      t.string :content

      t.timestamps null: false
    end
  end
end
