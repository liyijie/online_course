class AddScopeToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :scope, :integer, default: 1 #课程类别，1为校级，2为市级
  end
end
