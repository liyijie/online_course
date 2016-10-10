module ApplyCoursesHelper
	# 判断课程申报日期
	# true: >= 当前year
	# false: < 当前year
	def is_applying? applied_date_string
		if applied_date_string.present?
			applied_year = applied_date_string[0..3].to_i
			now_year = Time.now.year.to_i
			return applied_year >= now_year
		else
			return false
		end
	end
end
