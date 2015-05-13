class Question < ActiveRecord::Base
  belongs_to :sub_course
  has_many :options
end
