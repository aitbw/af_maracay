get '/dashboard/students' do
  set_page_title('Estudiantes')
  @students = Student.search_student(params[:cedula]).page(params[:page])
  erb :'students/students', layout: :'layouts/main'
end

get '/dashboard/students/new_student' do
  set_page_title('Crear nuevo estudiante')
  @sections = Section.where('section_hours != ? AND is_finished = ?', 0, false)
  erb :'students/new_student', layout: :'layouts/main'
end

post '/dashboard/students/new_student' do
  new_student
end

get '/dashboard/students/:id/delete' do
  set_page_title('Eliminar estudiante')
  @student = Student.find(params[:id])
  erb :'students/delete_student', layout: :'layouts/main'
end

delete '/dashboard/students/:id/delete' do
  delete_student(params[:id])
end

get '/dashboard/students/:id/edit' do
  set_page_title('Editar estudiante')
  @student = Student.find(params[:id])
  erb :'students/edit_student', layout: :'layouts/main'
end

put '/dashboard/students/:id/edit' do
  edit_student(params[:id])
end

get '/dashboard/students/:id/grades' do
  set_page_title('Calificaciones')
  @student = Student.find(params[:id])
  @grades = Grade.where(student_id: params[:id]).includes(:section).page(params[:page])
  erb :'grades/grades', layout: :'layouts/main'
end
