class Batch < ActiveRecord::Base

  # 创建测试用考试数据
  def self.exams
    sub_course = Question.first.sub_course
    questions = sub_course.questions
    
    #保证最少对的题数
    less_right = questions.size/2 + 2

    chars = ["A","B","C","D"]
    answers = {}
    Academy.where(name: "计算机信息系").first.users.find_each do |user|
      # 设置缺考的人
      id_str = user.number
      no = id_str.to_s[id_str.size-1].to_i

      # 学生位数为2的人设为缺考
      unless no == 2
        questions.each_with_index do |question, index|
          if index <= less_right
            answers[question.id] = question.correct_option.strip
          else
            answers[question.id] = chars[rand(chars.size)]
          end
        end
        exam = Exam.new
        exam.user_id = user.id
        exam.sub_course_id = sub_course.id
        exam.generate_by_answer_params(answers)
      end
    end
  end

end