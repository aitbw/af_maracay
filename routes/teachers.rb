get '/dashboard/teachers' do
  titulo('Profesores')
  @teachers = Teacher.all
  erb :teachers, layout: :'layouts/dashboard'
end

get '/dashboard/teachers/new_teacher' do
  titulo('Crear nuevo profesor')
  erb :new_teacher, layout: :'layouts/dashboard'
end

post '/dashboard/teachers/new_teacher' do
  nuevo_profesor
end

get '/dashboard/teachers/delete/:id' do
  begin
    Teacher.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor no existe.'
  else
    @id_profesor = params[:id]
    @query = Teacher.find(params[:id])
    titulo('Eliminar profesor')
    erb :delete_teacher, layout: :'layouts/dashboard'
  end
end

delete '/delete_teacher/:id' do
  if Teacher.destroy(params[:id])
    redirect '/dashboard/teachers', notice: 'Profesor eliminado.'
  else
    redirect "/dashboard/teachers/delete/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/edit/:id' do
  begin
    Teacher.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor no existe.'
  else
    @id_profesor = params[:id]
    @teacher = Teacher.find(params[:id])
    titulo('Editar profesor')
    erb :edit_teacher, layout: :'layouts/dashboard'
  end
end

put '/edit_teacher/:id' do
  t = Teacher.find(params[:id])
  EMAIL_REGEX ||= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  if params[:nombre].blank?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Debe completar todos los campos.'
  else
    t.nombreProfesor = params[:nombre]
  end

  if t.correoProfesor == params[:correo]
    t.correoProfesor = t.correoProfesor
  elsif EMAIL_REGEX.match(params[:correo]).nil?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Correo inválido.'
  elsif Teacher.where(correoProfesor: params[:correo]).present?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'El correo ya existe.'
  else
    t.correoProfesor = params[:correo]
  end

  if /\d{4}-?\d{7}/.match(params[:telefono]).nil?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Número inválido.'
  else
    t.telefonoProfesor = params[:telefono]
  end

  if t.cedulaProfesor == params[:cedula]
    t.cedulaProfesor = t.cedulaProfesor
  elsif /\d{6,8}/.match(params[:cedula]).nil?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Cédula inválida.'
  elsif Teacher.where(cedulaProfesor: params[:cedula]).present?
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'La cédula ya existe.'
  else
    t.cedulaProfesor = params[:cedula]
  end

  if t.save
    redirect '/dashboard/teachers', notice: 'Datos actualizados.'
  else
    redirect "/dashboard/teachers/edit/#{params[:id]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/bank_accounts/:id' do
  begin
    Teacher.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor no existe.'
  else
    titulo('Cuentas bancarias')
    @id_profesor = params[:id]
    @accounts = Account.where(idProfesor: params[:id])
    erb :bank_accounts, layout: :'layouts/dashboard'
  end
end

get '/dashboard/teachers/bank_accounts/:id/add' do
  begin
    Teacher.find(params[:id]).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor no existe.'
  else
    titulo('Asignar cuenta bancaria')
    @id_profesor = params[:id]
    @banks = Banco.all
    erb :add_bank_account, layout: :'layouts/dashboard'
  end
end

post '/dashboard/teachers/bank_accounts/:id/add' do
  asignar_cuenta
end

get '/dashboard/teachers/bank_accounts/:idT/delete/:idC' do
  begin
    (Teacher.find(params[:idT]) || Account.find(params[:idC])).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor o la cuenta bancaria asociada no existen.'
  else
    titulo('Eliminar cuenta bancaria')
    @id_profesor = params[:idT]
    @id_cuenta = params[:idC]
    @cuenta = Account.find(params[:idC])
    erb :delete_bank_account, layout: :'layouts/dashboard'
  end
end

delete '/:idT/delete_bank_account/:idC' do
  if Account.destroy(params[:idC])
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}", notice: 'Cuenta bancaria eliminada.'
  else
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}/delete/#{params[:idC]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end

get '/dashboard/teachers/bank_accounts/:idT/edit/:idC' do
  begin
    (Teacher.find(params[:idT]) || Account.find(params[:idC])).present?
  rescue ActiveRecord::RecordNotFound
    redirect '/dashboard/teachers', error: 'El profesor o la cuenta bancaria asociada no existen.'
  else
    titulo('Editar cuenta bancaria')
    @id_profesor = params[:idT]
    @id_cuenta = params[:idC]
    @cuenta = Account.find(params[:idC])
    @bank = Banco.all
    erb :edit_bank_account, layout: :'layouts/dashboard'
  end
end

put '/:idT/edit_bank_account/:idC' do
  c = Account.find(params[:idC])

  c.tipoCuenta = params[:tipo]
  c.idBanco = params[:banco]

  if /\d{20}/.match(params[:numero]).nil?
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}/edit/#{params[:idC]}", error: 'Número de cuenta inválido.'
  else
    c.numeroCuenta = params[:numero]
  end

  if c.save
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}", notice: 'Datos actualizados.'
  else
    redirect "/dashboard/teachers/bank_accounts/#{params[:idT]}/edit/#{params[:idC]}", error: 'Ha ocurrido un error, intente nuevamente.'
  end
end
