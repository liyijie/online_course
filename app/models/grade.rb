class Grade < ActiveRecord::Base
	belongs_to :academy
	has_many :users
end
