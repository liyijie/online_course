class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.integer :academy_id
      t.string :name
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
