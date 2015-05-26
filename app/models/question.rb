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
#

class Question < ActiveRecord::Base
  belongs_to :sub_course
  has_many :options, dependent: :destroy

  require 'csv' #注意必须小写
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Users.create! row.to_hash
    end
  end
end
