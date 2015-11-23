class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.references :teacher, index: true
      t.references :course, index: true
      t.string :name
      t.text :content
      t.date :start_at
      t.date :end_at


      t.timestamps null: false
    end
  end
end
