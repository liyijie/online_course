# == Schema Information
#
# Table name: teachers
#
#  id                     :integer          not null, primary key
#  phone                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  username               :string(255)      default("")
#  number                 :string(255)
#  name                   :string(255)
#  avatar                 :string(255)
#  birthday               :string(255)
#  tec_position           :string(255)
#  email                  :string(255)
#  qualification          :string(255)
#  fax                    :string(255)
#  final_education        :string(255)
#  final_degree           :string(255)
#  tec_expertise          :string(255)
#  resume                 :text(65535)
#  tec_situation          :text(65535)
#  tec_service            :text(65535)
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
