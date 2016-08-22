class AddGradesAssignedAttrToSections < ActiveRecord::Migration
  def change
    change_table :sections do |t|
      t.boolean :grades_assigned, null: false, default: false
    end
  end
end
