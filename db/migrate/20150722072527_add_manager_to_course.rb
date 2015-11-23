class AddManagerToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :manager, :integer
  end
end
