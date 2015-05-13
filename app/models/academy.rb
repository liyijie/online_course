class Academy < ActiveRecord::Base
	belongs_to :school
	has_many :grades
end
