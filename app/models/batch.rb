class Batch < ActiveRecord::Base

  # 创建测试用考试数据
  def self.exams
    sub_course = Question.first.sub_course
    questions = sub_course.questions
    chars = ["A","B","C","D"]
    answers = {}
    Academy.where(name: "计算机信息系").first.users.find_each do |user|
      questions.each do |question|
        answers[question.id] = chars[rand(chars.size-1)]
      end
      exam = Exam.new
      exam.user_id = user.id
      exam.sub_course_id = sub_course.id
      exam.generate_by_answer_params(answers)
    end
  end

end