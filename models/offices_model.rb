# Modelo para la tabla 'sedes'
class Office < ActiveRecord::Base
  has_many :courses
end
