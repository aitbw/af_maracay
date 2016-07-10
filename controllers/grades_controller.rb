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

def batch_grade_assignment
  course = Course.find(params[:id])
  ActiveRecord::Base.transaction do
    if Grade.create(params[:grade])
      course.update(grades_assigned: true)
      redirect '/dashboard/courses', notice: 'Calificaciones asignadas.'
    else
      flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
      redirect(request.path_info.to_s)
    end
  end
end

def edit_grade; end

def delete_grade
  if Grade.destroy(params[:grade])
    flash[:notice] = 'Calificación eliminada.'
    redirect "/dashboard/students/#{params[:student]}/grades"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end
