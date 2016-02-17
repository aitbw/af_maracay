# Model for 'offices' table
class Office < ActiveRecord::Base
  # Relations
  has_many :courses
end
