# Model for 'levels' table
class Level < ActiveRecord::Base
  # Relations
  has_many :sections
end
