class CreateManagerCourses < ActiveRecord::Migration
  def change
    create_table :manager_courses do |t|
      t.references :manager, index: true
      t.references :course, index: true

      t.timestamps null: false
    end
  end
end
