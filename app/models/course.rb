# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  number      :string
#  name        :string
#  description :text
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Course < ActiveRecord::Base
	has_many :sub_courses
end
