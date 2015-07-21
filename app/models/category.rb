class Category < ActiveRecord::Base
	has_many :sub_courses

	#软删除分类，记录删除时间
	def soft_destroy
		self.update(deleted_at: Time.current)
	end
end
