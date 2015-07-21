# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null
#  t.string   "name",       limit: 255
#  t.datetime "deleted_at"
#  t.datetime "created_at",             null: false
#  t.datetime "updated_at",             null: false
#

class Category < ActiveRecord::Base
	has_many :sub_courses

	#软删除分类，记录删除时间
	def soft_destroy
		self.update(deleted_at: Time.current)
	end
end
