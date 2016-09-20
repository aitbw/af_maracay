get '/dashboard/students/:id/signups' do
  set_page_title('Inscripciones')
  @student = Student.find(params[:id])
  @signups = Payment.where('payment_description = ? AND student_id = ?', 'Inscripción', params[:id]).includes(:user).page(params[:page])
  erb :signups, user_layout
end

get '/dashboard/students/:id/signups/new' do
  set_page_title('Nueva inscripción')
  @banks = Bank.all
  erb :'new/new_signup', user_layout
end

post '/dashboard/students/:id/signups/new' do
  new_signup = Payment.new(params[:payment])

  if new_signup.save
    flash[:notice] = 'Inscripción generada exitosamente.'
    redirect "/dashboard/students/#{params[:id]}/signups"
  else
    flash[:errors] = new_signup.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:student/signups/:signup/delete' do
  set_page_title('Eliminar inscripción')
  @signup = Payment.find(params[:signup])
  erb :'delete/delete_signup', user_layout
end

delete '/dashboard/students/:student/signups/:signup/delete' do
  if Payment.destroy(params[:signup])
    flash[:notice] = 'Inscripción eliminada.'
    redirect "/dashboard/students/#{params[:student]}/signups"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:student/signups/:signup/edit' do
  set_page_title('Editar inscripción')
  @signup = Payment.find(params[:signup])
  @banks = Bank.all
  erb :'edit/edit_signup', user_layout
end

put '/dashboard/students/:student/signups/:signup/edit' do
  edit_signup = Payment.find(params[:signup])

  if edit_signup.update(params[:form])
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/students/#{params[:student]}/signups"
  else
    flash[:errors] = edit_signup.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:id/fees' do
  set_page_title('Cuotas')
  @student = Student.find(params[:id])
  @fees = Payment.where('payment_description = ? AND student_id = ?', 'Cuota', params[:id]).includes(:user).page(params[:page])
  erb :fees, user_layout
end

get '/dashboard/students/:id/fees/new' do
  set_page_title('Nueva cuota')
  @student = Student.find(params[:id])
  @banks = Bank.all
  erb :'new/new_fee', user_layout
end

post '/dashboard/students/:id/fees/new' do
  new_fee = Payment.new(params[:payment])

  if new_fee.save
    flash[:notice] = 'Cuota generada exitosamente.'
    redirect "/dashboard/students/#{params[:id]}/fees"
  else
    flash[:errors] = new_fee.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:student/fees/:fee/delete' do
  set_page_title('Eliminar cuota')
  @fee = Payment.find(params[:fee])
  erb :'delete/delete_fee', user_layout
end

delete '/dashboard/students/:student/fees/:fee/delete' do
  if Payment.destroy(params[:fee])
    flash[:notice] = 'Cuota eliminada.'
    redirect "/dashboard/students/#{params[:student]}/fees"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/students/:student/fees/:fee/edit' do
  set_page_title('Editar cuota')
  @banks = Bank.all
  @fee = Payment.find(params[:fee])
  erb :'edit/edit_fee', user_layout
end

put '/dashboard/students/:student/fees/:fee/edit' do
  edit_fee = Payment.find(params[:fee])

  if edit_fee.update(params[:form])
    flash[:notice] = 'Datos actualizados.'
    redirect "/dashboard/students/#{params[:student]}/fees"
  else
    flash[:errors] = edit_fee.errors.full_messages
    redirect(request.path_info.to_s)
  end
end
