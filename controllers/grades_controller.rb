# Helper to keep exception handling DRY
def find_grade(student, grade)
  Grade.find(grade).present?
rescue ActiveRecord::RecordNotFound
  flash[:error] = 'La nota asociada no existe.'
  redirect "/dashboard/students/#{student}/grades"
end

before %r{\/dashboard\/students\/(\d)\/grades\/(\d)\/(delete|edit)} do |student, grade, _|
  find_student(student) && find_grade(student, grade)
end

def new_grade; end

def edit_grade; end

def delete_grade; end
