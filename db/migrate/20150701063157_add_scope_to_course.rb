class AddScopeToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :scope, :integer, default: 1 #课程类别，1为市级，2为校级
  end
end
