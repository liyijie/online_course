module NumberHelper
	def self.random_course_number
    number = 0
    number = SecureRandom.random_number(100_000_000) until number > 9_999_999
    number
  end
end