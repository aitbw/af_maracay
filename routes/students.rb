# Helpers to keep exception handling DRY
def find_student(id)
  Student.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/students', error: 'El estudiante no existe.'
end

def find_signup(student, signup)
  Signup.find(signup).present?
rescue ActiveRecord::RecordNotFound
  flash[:error] = 'La inscripción asociada no existe.'
  redirect "/dashboard/students/#{student}/signups"
end

def find_fee(student, fee)
  Fee.find(fee).present?
rescue ActiveRecord::RecordNotFound
  flash[:error] = 'La cuota asociada no existe.'
  redirect "/dashboard/students/#{student}/fees"
end

before %r{\/dashboard\/students\/(\d)\/(delete|edit)} do |id, _|
  find_student(id)
end

before %r{\/dashboard\/students\/(\d)\/(signups|fees)\/(\d)\/(delete|edit)} do |student, action, id, _|
  case action
  when 'signups'
    find_student(student) && find_signup(student, id)
  when 'fees'
    find_student(student) && find_fee(student, id)
  end
end

get '/dashboard/students' do
  set_page_title('Estudiantes')
  @students = Student.all
  erb :students, layout: :'layouts/dashboard'
end

get '/dashboard/students/new_student' do
  set_page_title('Crear nuevo estudiante')
  @courses = Course.where.not(course_hours: 0).select(:course_id, :course_code)
  erb :'new/new_student', layout: :'layouts/dashboard'
end

post '/dashboard/students/new_student' do
  new_student
end

get '/dashboard/students/:id/delete' do
  @student = Student.find(params[:id])
  set_page_title('Eliminar estudiante')
  erb :'delete/delete_student', layout: :'layouts/dashboard'
end

delete '/dashboard/students/:id/delete' do
  if Student.destroy(params[:id])
    redirect '/dashboard/students', notice: 'Estudiante eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end

get '/dashboard/students/:id/edit' do
  @student = Student.find(params[:id])
  set_page_title('Editar estudiante')
  erb :'edit/edit_student', layout: :'layouts/dashboard'
end

put '/dashboard/students/:id/edit' do
  edit_student = Student.find(params[:id])
  edit_student.update(params[:student])
  if edit_student.save
    redirect '/dashboard/students', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_student.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/students/:id/signups' do
  if find_student(params[:id])
    @student_id = params[:id]
    @signups = Signup.where(student_id: params[:id]).order(issue_date: :desc).includes(:user)
    set_page_title('Inscripciones')
    erb :signups, layout: :'layouts/dashboard'
  end
end

get '/dashboard/students/:id/signups/add' do
  if find_student(params[:id])
    @student_id = params[:id]
    @banks = Bank.all
    set_page_title('Nueva inscripción')
    erb :'new/new_signup', layout: :'layouts/dashboard'
  end
end

post '/dashboard/students/:id/signups/add' do
  if find_student(params[:id])
    new_signup = Signup.new(params[:signup])

    if new_signup.save
      flash[:notice] = 'Inscripción generada exitosamente.'
      redirect "/dashboard/students/#{params[:id]}/signups"
    else
      flash[:errors] = new_signup.errors.full_messages
      redirect "#{request.path_info}"
    end
  end
end

get '/dashboard/students/:student/signups/:signup/delete' do
  set_page_title('Eliminar inscripción')
  @signup = Signup.find(params[:signup])
  erb :'delete/delete_signup', layout: :'layouts/dashboard'
end

delete '/dashboard/students/:student/signups/:signup/delete' do
  if Signup.destroy(params[:signup])
    flash[:notice] = 'Inscripción eliminada.'
    redirect "/dashboard/students/#{params[:student]}/signups"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end

get '/dashboard/students/:student/signups/:signup/edit' do
  set_page_title('Editar inscripción')
  @signup = Signup.find(params[:signup])
  @banks = Bank.all
  erb :'edit/edit_signup', layout: :'layouts/dashboard'
end

put '/dashboard/students/:student/signups/:signup/edit' do
  edit_signup = Signup.find(params[:signup])
  if edit_signup.update(params[:form])
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/students/#{params[:student]}/signups"
  else
    flash[:errors] = edit_signup.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/students/:id/fees' do
  if find_student(params[:id])
    set_page_title('Cuotas')
    @student_id = params[:id]
    @fees = Fee.where(student_id: params[:id]).order(issue_date: :desc).includes(:user)
    erb :fees, layout: :'layouts/dashboard'
  end
end

get '/dashboard/students/:id/fees/add' do
  if find_student(params[:id])
    set_page_title('Nueva cuota')
    @banks = Bank.all
    @student_id = params[:id]
    erb :'new/new_fee', layout: :'layouts/dashboard'
  end
end

post '/dashboard/students/:id/fees/add' do
  if find_student(params[:id])
    new_fee = Fee.new(params[:fee])

    if new_fee.save
      flash[:notice] = 'Cuota generada exitosamente.'
      redirect "/dashboard/students/#{params[:id]}/fees"
    else
      flash[:errors] = new_fee.errors.full_messages
      redirect "#{request.path_info}"
    end
  end
end

get '/dashboard/students/:student/fees/:fee/delete' do
  set_page_title('Eliminar cuota')
  @fee = Fee.find(params[:fee])
  erb :'delete/delete_fee', layout: :'layouts/dashboard'
end

delete '/dashboard/students/:student/fees/:fee/delete' do
  if Fee.destroy(params[:fee])
    flash[:notice] = 'Cuota eliminada.'
    redirect "/dashboard/students/#{params[:student]}/fees"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end

get '/dashboard/students/:student/fees/:fee/edit' do
  set_page_title('Editar cuota')
  @fee = Fee.find(params[:fee])
  erb :'edit/edit_fee', layout: :'layouts/dashboard'
end

put '/dashboard/students/:student/fees/:fee/edit' do
  edit_fee = Fee.find(params[:fee])
  if edit_fee.update(params[:form])
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/students/#{params[:student]}/fees"
  else
    flash[:errors] = edit_fee.errors.full_messages
    redirect "#{request.path_info}"
  end
end

get '/dashboard/students/:id/grades' do
  if find_student(params[:id])
    set_page_title('Notas')
    @student_id = params[:id]
    @grades = Grade.where(student_id: params[:id])
    erb :grades, layout: :'layouts/dashboard'
  end
end
