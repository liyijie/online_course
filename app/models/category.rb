# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
	has_many :sub_courses
	validates :name, presence: true

	#软删除分类，记录删除时间
	def soft_destroy
		self.update(deleted_at: Time.current)
	end
end
