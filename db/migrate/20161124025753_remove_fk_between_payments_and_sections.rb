# Removing 'section_id' foreign key from payments
class RemoveFkBetweenPaymentsAndSections < ActiveRecord::Migration
  def change
    remove_foreign_key :payments, column: :section_id
    remove_column :payments, :section_id, :int
  end
end
