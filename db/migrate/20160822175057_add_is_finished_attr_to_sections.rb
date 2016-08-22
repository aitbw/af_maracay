class AddIsFinishedAttrToSections < ActiveRecord::Migration
  def change
    change_table :sections do |t|
      t.boolean :is_finished, null: false, default: false
    end
  end
end
