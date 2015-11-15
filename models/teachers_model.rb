# Model for 'teachers' table
class Teacher < ActiveRecord::Base
  VALID_EMAIL ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_NUMBER ||= /04(12|14|24|16|26)-?\d{7}/
  has_many :bank_accounts, dependent: :destroy

  validates :teacher_name, presence: true
  validates :teacher_phone, presence: true, format: { with: VALID_NUMBER }
  validates :teacher_email, presence: true, uniqueness: true, format: { with: VALID_EMAIL }
  validates :teacher_cedula, presence: true, uniqueness: true, format: { with: /\d{6,8}/ }
  validates :entry_date, presence: true
end
