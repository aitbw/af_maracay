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

before %r{\/(delete|edit)_student\/(\d)} do |_, id|
  find_student(id)
end

before %r{\/(\d)\/(delete|edit)_(signup|fee)\/(\d)} do |student, _, action, id|
  case action
  when 'signup'
    find_student(student) && find_signup(student, id)
  when 'fee'
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
  @courses = Course.select(:course_id, :course_code)
  erb :new_student, layout: :'layouts/dashboard'
end

post '/dashboard/students/new_student' do
  new_student
end

get '/dashboard/students/:id/delete' do
  if find_student(params[:id])
    @student_id = params[:id]
    @student = Student.find(params[:id])
    set_page_title('Eliminar estudiante')
    erb :delete_student, layout: :'layouts/dashboard'
  end
end

delete '/delete_student/:id' do
  if Student.destroy(params[:id])
    redirect '/dashboard/students', notice: 'Estudiante eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/students/#{params[:id]}/delete"
  end
end

get '/dashboard/students/:id/edit' do
  if find_student(params[:id])
    @student_id = params[:id]
    @student = Student.find(params[:id])
    set_page_title('Editar estudiante')
    erb :edit_student, layout: :'layouts/dashboard'
  end
end

put '/edit_student/:id' do
  edit_student = Student.find(params[:id])
  edit_student.update(params[:student])
  if edit_student.save
    redirect '/dashboard/students', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_student.errors.full_messages
    redirect "/dashboard/students/edit/#{params[:id]}"
  end
end

get '/dashboard/students/:id/signups' do
  if find_student(params[:id])
    @student_id = params[:id]
    @signups = Signup.where(student_id: params[:id]).order(issue_date: :desc)
    set_page_title('Inscripciones')
    erb :signups, layout: :'layouts/dashboard'
  end
end

get '/dashboard/students/:id/signups/add' do
  if find_student(params[:id])
    @student_id = params[:id]
    @js = ['moment.min.js', 'bootstrap-datetimepicker.min.js']
    @banks = Bank.all
    set_page_title('Nueva inscripción')
    erb :new_signup, layout: :'layouts/dashboard'
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
      redirect "/dashboard/students/#{params[:id]}/signups/add"
    end
  end
end

get '/dashboard/students/:student/signups/:signup/delete' do
  if find_student(params[:student]) && find_signup(params[:student], params[:signup])
    set_page_title('Eliminar inscripción')
    @student_id = params[:student]
    @signup_id = params[:signup]
    @signup = Signup.find(params[:signup])
    erb :delete_signup, layout: :'layouts/dashboard'
  end
end

delete '/:student/delete_signup/:signup' do
  if Signup.destroy(params[:signup])
    flash[:notice] = 'Inscripción eliminada.'
    redirect "/dashboard/students/#{params[:student]}/signups"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "/dashboard/students/#{params[:student]}/signups/#{params[:signup]}/delete"
  end
end

get '/dashboard/students/:student/signups/:signup/edit' do
  if find_student(params[:student]) && find_signup(params[:student], params[:signup])
    set_page_title('Editar inscripción')
    @student_id = params[:student]
    @signup_id  = params[:signup]
    @signup = Signup.find(params[:signup])
    @banks = Bank.all
    erb :edit_signup, layout: :'layouts/dashboard'
  end
end

put '/:student/edit_signup/:signup' do
  edit_signup = Signup.find(params[:signup])
  edit_signup.update(params[:form])
  if edit_signup.save
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/students/#{params[:student]}/signups"
  else
    flash[:errors] = edit_signup.errors.full_messages
    redirect "/dashboard/students/#{params[:student]}/signups/#{params[:signup]}/edit"
  end
end

get '/dashboard/students/:id/fees' do
  if find_student(params[:id])
    set_page_title('Cuotas')
    @student_id = params[:id]
    @fees = Fee.where(student_id: params[:id]).order(issue_date: :desc)
    erb :fees, layout: :'layouts/dashboard'
  end
end

get '/dashboard/students/:id/fees/add' do
  if find_student(params[:id])
    set_page_title('Nueva cuota')
    @banks = Bank.all
    @js = ['moment.min.js', 'bootstrap-datetimepicker.min.js']
    @student_id = params[:id]
    erb :new_fee, layout: :'layouts/dashboard'
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
  if find_student(params[:student]) && find_fee(params[:student], params[:fee])
    set_page_title('Eliminar cuota')
    @fee = Fee.find(params[:fee])
    erb :delete_fee, layout: :'layouts/dashboard'
  end
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
  if find_student(params[:student]) && find_fee(params[:student], params[:fee])
    set_page_title('Editar cuota')
    @fee = Fee.find(params[:fee])
    erb :edit_fee, layout: :'layouts/dashboard'
  end
end

put '/dashboard/students/:student/fees/:fee/edit' do
  edit_fee = Fee.find(params[:fee])
  edit_fee.update(params[:form])
  if edit_fee.save
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/students/#{params[:student]}/fees"
  else
    flash[:error] = 'Ha ocurrido un erorr, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end
