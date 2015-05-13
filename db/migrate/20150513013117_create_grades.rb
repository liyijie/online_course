class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :academy_id
      t.string :name
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
