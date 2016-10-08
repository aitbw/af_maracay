get '/dashboard/courses/:id/sections' do
  @course_code = Course.where(course_id: params[:id]).pluck(:course_code).first
  set_page_title("Secciones del curso #{@course_code}")
  @sections = Section.where(course_id: params[:id]).page(params[:page]).includes(:level)
  erb :sections, user_layout
end

get '/dashboard/courses/:course/sections/:section/students/show' do
  @section = Section.find(params[:section])
  set_page_title("Estudiantes del nivel #{@section.level_description}")
  @section_students = Student.where(section_id: params[:section])
  erb :section_students, user_layout
end

get '/dashboard/courses/:id/sections/new' do
  set_page_title('Crear nueva sección')
  @levels = Level.all
  erb :'new/new_section', user_layout
end

post '/dashboard/courses/:id/sections/new' do
  @course = Course.find(params[:id])
  new_section = @course.sections.create(params[:section])

  if new_section.save
    flash[:notice] = 'Sección creada correctamente,'
    redirect "/dashboard/courses/#{params[:id]}/sections"
  else
    flash[:errors] = new_section.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/courses/:course/sections/:section/delete' do
  set_page_title('Eliminar sección')
  @section = Section.find(params[:section])
  erb :'delete/delete_section', user_layout
end

delete '/dashboard/courses/:course/sections/:section/delete' do
  if Section.destroy(params[:section])
    flash[:notice] = 'Sección eliminada.'
    redirect "/dashboard/courses/#{params[:course]}/sections"
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/courses/:course/sections/:section/edit' do
  set_page_title('Editar sección')
  @section = Section.find(params[:section])
  @courses = Course.all
  @levels = Level.all
  erb :'edit/edit_section', user_layout
end

put '/dashboard/courses/:course/sections/:section/edit' do
  edit_section = Section.find(params[:section])

  if edit_section.update(params[:form])
    flash[:notice] = 'Datos actualizados'
    redirect "/dashboard/courses/#{params[:course]}"
  else
    flash[:errors] = edit_section.errors.full_messages
    redirect(request.path_info.to_s)
  end
end
