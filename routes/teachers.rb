# Helpers to keep exception handling DRY
def find_teacher(id)
  Teacher.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/teachers', error: 'El profesor no existe.'
end

def find_account(teacher, account)
  BankAccount.find(account).present?
rescue ActiveRecord::RecordNotFound
  flash[:error] = 'La cuenta asociada no existe.'
  redirect "/dashboard/teachers/#{teacher}/bank_accounts"
end

before %r{\/dashboard\/teachers\/(\d)\/(delete|edit)} do |id, _|
  find_teacher(id)
end

before %r{\/dashboard\/teachers\/(\d)\/bank_accounts\/(\d)\/(delete|edit)} do |teacher, account, _|
  find_teacher(teacher) && find_account(teacher, account)
end

get '/dashboard/teachers' do
  set_page_title('Profesores')
  @teachers = Teacher.search_teacher(params[:cedula]).paginate(page: params[:page])
  erb :teachers, user_layout
end

get '/dashboard/teachers/new_teacher' do
  set_page_title('Crear nuevo profesor')
  erb :'new/new_teacher', user_layout
end

post '/dashboard/teachers/new_teacher' do
  new_teacher
end

get '/dashboard/teachers/:id/delete' do
  @teacher = Teacher.find(params[:id])
  set_page_title('Eliminar profesor')
  erb :'delete/delete_teacher', user_layout
end

delete '/dashboard/teachers/:id/delete' do
  if Teacher.destroy(params[:id])
    redirect '/dashboard/teachers', notice: 'Profesor eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end

get '/dashboard/teachers/:id/edit' do
  @teacher = Teacher.find(params[:id])
  set_page_title('Editar profesor')
  erb :'edit/edit_teacher', user_layout
end

put '/dashboard/teachers/:id/edit' do
  edit_teacher = Teacher.find(params[:id])
  if edit_teacher.update(params[:teacher])
    redirect '/dashboard/teachers', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_teacher.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/teachers/:id/bank_accounts' do
  if find_teacher(params[:id])
    set_page_title('Cuentas bancarias')
    @teacher_id = params[:id]
    @accounts = BankAccount.where(teacher_id: params[:id])
    erb :bank_accounts, user_layout
  end
end

get '/dashboard/teachers/:id/bank_accounts/add' do
  if find_teacher(params[:id])
    set_page_title('Asignar cuenta bancaria')
    @teacher_id = params[:id]
    @banks = Bank.all
    erb :'new/new_bank_account', user_layout
  end
end

post '/dashboard/teachers/:id/bank_accounts/add' do
  assign_account if find_teacher(params[:id])
end

get '/dashboard/teachers/:teacher/bank_accounts/:account/delete' do
  set_page_title('Eliminar cuenta bancaria')
  @account = BankAccount.find(params[:account])
  erb :'delete/delete_bank_account', user_layout
end

delete '/dashboard/teachers/:teacher/bank_accounts/:account/delete' do
  if BankAccount.destroy(params[:account])
    flash[:notice] = 'Cuenta bancaria eliminada.'
    redirect "/dashboard/teachers/#{params[:teacher]}/bank_accounts"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end

get '/dashboard/teachers/:teacher/bank_accounts/:account/edit' do
  set_page_title('Editar cuenta bancaria')
  @account = BankAccount.find(params[:account])
  @banks = Bank.all
  erb :'edit/edit_bank_account', user_layout
end

put '/dashboard/teachers/:teacher/bank_accounts/:account/edit' do
  edit_account = BankAccount.find(params[:account])
  if edit_account.update(params[:form])
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/teachers/#{params[:teacher]}/bank_accounts"
  else
    flash[:errors] = edit_account.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/teachers/:id/courses' do
  if find_teacher(params[:id])
    set_page_title('Cursos asignados')
    @teacher = Teacher.find(params[:id])
    @courses = @teacher.courses.includes(:course_type)
    erb :teacher_courses, user_layout
  end
end

get '/dashboard/teachers/:id/courses/assign' do
  if find_teacher(params[:id])
    set_page_title('Asignar curso')
    @teacher = Teacher.find(params[:id])
    @courses = @teacher.courses.includes(:course_type)
    @available_courses = Course.where.not(course_hours: 0).select(:course_id, :course_code, :course_level)
    erb :'assign/assign_course', user_layout
  end
end

post '/dashboard/teachers/:teacher/courses/assign' do
  course_teacher = CourseTeacher.new(course_id: params[:course], teacher_id: params[:teacher])

  if course_teacher.save
    flash[:notice] = 'Curso asignado.'
    redirect "/dashboard/teachers/#{params[:teacher]}/courses"
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
