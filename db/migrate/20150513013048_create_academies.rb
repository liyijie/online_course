class CreateAcademies < ActiveRecord::Migration
  def change
    create_table :academies do |t|
      t.integer :school_id
      t.string :name
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
