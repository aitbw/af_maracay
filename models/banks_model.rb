# Modelo para la tabla 'bancos'
class Banco < ActiveRecord::Base
  has_many :accounts, foreign_key: 'idBanco'
end
