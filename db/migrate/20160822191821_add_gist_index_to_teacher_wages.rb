class AddGistIndexToTeacherWages < ActiveRecord::Migration
  def change
    add_index :teachers, :teacher_wages, using: :gist
  end
end
