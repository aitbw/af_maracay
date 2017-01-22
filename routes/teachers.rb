get '/dashboard/teachers' do
  set_page_title(I18n.t('teachers.page_titles.main'))
  @teachers = Teacher.search_teacher(params[:cedula]).page(params[:page])
  erb :'teachers/teachers', layout: :'layouts/main'
end

get '/dashboard/teachers/new_teacher' do
  set_page_title(I18n.t('teachers.page_titles.new_teacher'))
  erb :'teachers/new_teacher', layout: :'layouts/main'
end

post '/dashboard/teachers/new_teacher' do
  new_teacher
end

get '/dashboard/teachers/:id/delete' do
  set_page_title(I18n.t('teachers.page_titles.delete_teacher'))
  @teacher = Teacher.find(params[:id])
  erb :'teachers/delete_teacher', layout: :'layouts/main'
end

delete '/dashboard/teachers/:id/delete' do
  delete_teacher(params[:id])
end

get '/dashboard/teachers/:id/edit' do
  set_page_title(I18n.t('teachers.page_titles.edit_teacher'))
  @teacher = Teacher.find(params[:id])
  erb :'teachers/edit_teacher', layout: :'layouts/main'
end

put '/dashboard/teachers/:id/edit' do
  edit_teacher(params[:id])
end

get '/dashboard/teachers/:id/courses' do
  set_page_title(I18n.t('teacher_courses.page_titles.assigned_courses'))
  @teacher = Teacher.find(params[:id])
  @courses = @teacher.courses.includes(:course_type, :office)
  erb :'teachers/teacher_courses', layout: :'layouts/main'
end

get '/dashboard/teachers/:id/courses/assign' do
  set_page_title(I18n.t('teacher_courses.page_titles.assign_course'))
  @teacher = Teacher.find(params[:id])
  @courses = @teacher.courses.includes(:course_type, :office)
  @available_courses = Course.where.not(
    course_id: @courses.pluck(:course_id)
  ).includes(:course_type)

  erb :'teachers/assign_course', layout: :'layouts/main'
end

post '/dashboard/teachers/:id/courses/assign' do
  course_teacher = CourseTeacher.new(params[:course_teacher])

  if course_teacher.save
    flash[:notice] = I18n.t('teacher_courses.messages.success.assigned_course')
    redirect "/dashboard/teachers/#{params[:id]}/courses"
  else
    flash[:error] = I18n.t('teacher_courses.messages.errors.failed_transaction')
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
    flash[:notice] = I18n.t('teacher_courses.messages.success.unlinked_teacher')
  else
    flash[:error] = I18n.t('teacher_courses.messages.errors.failed_transaction')
  end
  redirect("/dashboard/teachers/#{params[:teacher]}/courses")
end

get '/dashboard/teachers/:id/hours' do
  set_page_title(I18n.t('teacher_hours.page_titles.hours_covered'))
  @teacher = Teacher.find(params[:id])
  @hours = TeacherHour.where(
    teacher_id: params[:id]
  ).includes(:course).page(params[:page])

  erb :'teacher_hours/teacher_hours', layout: :'layouts/main'
end

get '/dashboard/teachers/:id/hours/assign' do
  set_page_title(I18n.t('teacher_hours.page_titles.assign_hours'))
  @teacher = Teacher.find(params[:id])
  @courses = @teacher.courses
  erb :'teacher_hours/assign_hours', layout: :'layouts/main'
end

post '/dashboard/teachers/:id/hours/assign' do
  teacher_hours = TeacherHour.new(params[:hours])

  if teacher_hours.save
    flash[:notice] = I18n.t('teacher_hours.messages.success.assigned_hours')
    redirect("/dashboard/teachers/#{params[:id]}/hours")
  else
    flash[:errors] = teacher_hours.errors
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/teachers/:teacher/hours/:hour/delete' do
  set_page_title(I18n.t('teacher_hours.page_titles.delete_assigned_hour'))
  @hour = TeacherHour.find(params[:hour])
  erb :'teacher_hours/delete_hour', layout: :'layouts/main'
end

delete '/dashboard/teachers/:teacher/hours/:hour/delete' do
  if TeacherHour.destroy(params[:hour])
    flash[:notice] = I18n.t('teacher_hours.messages.success.deleted_hour')
    redirect "/dashboard/teachers/#{params[:teacher]}/hours"
  else
    flash[:error] = I18n.t('teacher_hours.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end
