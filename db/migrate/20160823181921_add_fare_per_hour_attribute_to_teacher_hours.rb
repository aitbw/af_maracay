class AddFarePerHourAttributeToTeacherHours < ActiveRecord::Migration
  def change
    change_table :teacher_hours do |t|
      t.float :fare_per_hour, null: false
    end
  end
end
