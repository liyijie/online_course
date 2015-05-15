# == Schema Information
#
# Table name: teachers
#
#  id                     :integer          not null, primary key
#  phone                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  username               :string           default("")
#  number                 :string
#  name                   :string
#  avatar                 :string
#  birthday               :string
#  tec_position           :string
#  email                  :string
#  qualification          :string
#  fax                    :string
#  final_education        :string
#  final_degree           :string
#  tec_expertise          :string
#  resume                 :text
#  tec_situation          :text
#  tec_service            :text
#  deleted_at             :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

class Teacher < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable


  # Virtual attribute for authenticating by either username or phone
  attr_accessor :login

  validates_presence_of     :phone
  validates_uniqueness_of   :phone, case_sensitive: false
  validates :password, presence: true, length: {minimum:6,maximum: 32}
  validates_confirmation_of :password



  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup

   login = conditions.delete(:login)

   where(conditions).where(["lower(username) = :value OR lower(phone) = :value", { :value => login.strip.downcase }]).first
  end
end
