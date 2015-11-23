class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :number
      t.string :name
      t.text :description
      t.string :content

      t.timestamps null: false
    end
  end
end
