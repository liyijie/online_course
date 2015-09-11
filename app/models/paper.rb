class Paper < ActiveRecord::Base
  belongs_to :course

  validates_presence_of :course, :name, :start_at, :end_at, :attachment
end
