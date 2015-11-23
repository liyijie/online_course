class AddExcellentedToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :excellented, :boolean, default: false
  end
end
