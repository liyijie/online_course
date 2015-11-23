module CourseHelper

	#获取文件的格式
	def file_format file_name
		return if file_name.blank?
		File.extname(file_name).to_s.split(".").last
	end

end