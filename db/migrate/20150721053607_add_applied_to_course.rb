class AddAppliedToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :applied, :boolean, default: false
  end
end
