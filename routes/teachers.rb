get '/dashboard/teachers' do
  set_page_title('Profesores')
  @teachers = Teacher.search_teacher(params[:cedula]).page(params[:page])
  erb :'teachers/teachers', user_layout
end

get '/dashboard/teachers/new_teacher' do
  set_page_title('Crear nuevo profesor')
  erb :'teachers/new_teacher', user_layout
end

post '/dashboard/teachers/new_teacher' do
  new_teacher
end

get '/dashboard/teachers/:id/delete' do
  set_page_title('Eliminar profesor')
  @teacher = Teacher.find(params[:id])
  erb :'teachers/delete_teacher', user_layout
end

delete '/dashboard/teachers/:id/delete' do
  delete_teacher(params[:id])
end

get '/dashboard/teachers/:id/edit' do
  set_page_title('Editar profesor')
  @teacher = Teacher.find(params[:id])
  erb :'teachers/edit_teacher', user_layout
end

put '/dashboard/teachers/:id/edit' do
  edit_teacher(params[:id])
end

get '/dashboard/teachers/:id/courses' do
  set_page_title('Cursos asignados')
  @teacher = Teacher.find(params[:id])
  @courses = @teacher.courses.includes(:course_type)
  erb :'teachers/teacher_courses', user_layout
end

get '/dashboard/teachers/:id/courses/assign' do
  set_page_title('Asignar curso')
  @teacher = Teacher.find(params[:id])
  @courses = @teacher.courses.includes(:course_type, :office)
  @available_courses = Course.where.not(course_id: @courses.pluck(:course_id))
  erb :'teachers/assign_course', user_layout
end

post '/dashboard/teachers/:id/courses/assign' do
  course_teacher = CourseTeacher.new(params[:course_teacher])

  if course_teacher.save
    flash[:notice] = 'Curso asignado.'
    redirect "/dashboard/teachers/#{params[:id]}/courses"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end

# This route's function is to destroy a teacher's association with a
# course, so he/she won't have that course assigned anymore.
# Since my JS skills are zero to null, I've found a workaround to destroy
# the association almost inmediately without applying AJAX.
# A XHR will be added to the 'application.js' file to execute this route
# in future versions of the platform in order to improve UX.
get '/dashboard/teachers/:teacher/courses/:course/remove_teacher' do
  teacher = Teacher.find(params[:teacher])
  course = teacher.courses.find(params[:course])

  if course
    teacher.courses.delete(course)
    flash[:notice] = 'Profesor desvinculado del curso.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
  end
  redirect("/dashboard/teachers/#{params[:teacher]}/courses")
end

get '/dashboard/teachers/:id/hours' do
  set_page_title('Horas cubiertas')
  @teacher = Teacher.find(params[:id])
  @hours = TeacherHour.where(teacher_id: params[:id]).includes(:course).page(params[:page])
  erb :'teacher_hours/teacher_hours', user_layout
end

get '/dashboard/teachers/:id/hours/assign' do
  set_page_title('Asignar horas a profesor')
  @teacher = Teacher.find(params[:id])
  @courses = @teacher.courses
  erb :'teacher_hours/assign_hours', user_layout
end

post '/dashboard/teachers/:id/hours/assign' do
  teacher_hours = TeacherHour.new(params[:hours])

  if teacher_hours.save
    flash[:notice] = 'Horas asignadas al profesor con éxito.'
    redirect("/dashboard/teachers/#{params[:id]}/hours")
  else
    flash[:errors] = teacher_hours.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/teachers/:teacher/hours/:hour/delete' do
  set_page_title('Eliminar hora')
  @hour = TeacherHour.find(params[:hour])
  erb :'teacher_hours/delete_hour', user_layout
end

delete '/dashboard/teachers/:teacher/hours/:hour/delete' do
  if TeacherHour.destroy(params[:hour])
    flash[:notice] = 'Registro de horas eliminado.'
    redirect "/dashboard/teachers/#{params[:teacher]}/hours"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end
