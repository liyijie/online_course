# == Schema Information
#
# Table name: questions
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  signal_score   :integer
#  sub_course_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  correct_option :string(255)
#  correct_hint   :string(255)
#  deleted_at     :datetime
#

require 'csv'
class Question < ActiveRecord::Base
  belongs_to :sub_course
  has_many :options, dependent: :destroy
  validates_uniqueness_of :title, scope: :sub_course_id

  def self.import(file)
    allowed_attributes = [ "title", "correct_option", "correct_hint"]
    spreadsheet = open_spreadsheet(file)
    # header = ["title", "correct_option", "correct_hint", "option_1", "option_2", "option_3", "option_4"]
    header = spreadsheet.row(2)
    errors = []

    Question.transaction do
      (3..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        question = Question.new
        question.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
        if question.save
          option_length = row.length - 3  #行中减去question选项长度
          (1..option_length).each do |i|
            _opt = 'option_' + i.to_s
            option = question.options.new
            option.name = row[_opt]
            option.save!
          end
        else
          errors = errors + question.errors.full_messages
        end

        ActiveRecord::Rollback unless errors.blank?
      end

      errors
    end
   
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "未知格式: #{file.original_filename}"
    end
  end
end
