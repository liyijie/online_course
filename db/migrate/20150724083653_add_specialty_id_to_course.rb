class AddSpecialtyIdToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :specialty_id, :integer
  end
end
