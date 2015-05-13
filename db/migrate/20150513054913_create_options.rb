class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :index_type
      t.string :name
      t.boolean :be_right
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
