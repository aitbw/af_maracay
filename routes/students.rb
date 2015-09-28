get '/dashboard/students' do
  titulo('Estudiantes — Panel de control')
  @estudiantes = Estudiante.all
  erb :students, layout: :'layouts/dashboard'
end

get '/dashboard/students/new_student' do
  titulo('Crear nuevo estudiante — Panel de control')
  @cursos = Curso.select(:idCurso, :codigoCurso)
  erb :new_student, layout: :'layouts/dashboard'
end

post '/dashboard/students/new_student' do
  nuevo_estudiante
end
