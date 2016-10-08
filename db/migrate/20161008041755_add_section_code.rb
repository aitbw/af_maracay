# Student and Grade models are tighly tied to the
# Section model and since this model delegates
# the :level_description and :course_code, it's
# impossible for the former models to access these
# attributes, hence a :section_code attribute was
# created - which is mix between the aforementioned
# attributes generated automatically by the
# :generate_section_code callback on the Section model

# This way the end-users will know to which course
# and section the students belong to, or which section
# a teacher covered on a certain date

# If you know a better way to handle this issue, I encourage
# you to fork this project and submit a PR with your changes
# at https://github.com/aitbw/af_maracay
class AddSectionCode < ActiveRecord::Migration
  def change
    change_table :sections do |t|
      t.string :section_code, null: false, limit: 50
    end
  end
end
