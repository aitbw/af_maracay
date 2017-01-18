get '/dashboard/students' do
  set_page_title(I18n.t('students.page_titles.students'))
  @students = Student.search_student(params[:cedula]).page(params[:page])
  erb :'students/students', user_layout
end

get '/dashboard/students/new_student' do
  set_page_title(I18n.t('students.page_titles.new_student'))
  @sections = Section.where('section_hours != ? AND is_finished = ?', 0, false)
  erb :'students/new_student', user_layout
end

post '/dashboard/students/new_student' do
  create_new_student
end

get '/dashboard/students/:id/delete' do
  set_page_title(I18n.t('students.page_titles.delete_student'))
  @student = Student.find(params[:id])
  erb :'students/delete_student', user_layout
end

delete '/dashboard/students/:id/delete' do
  delete_student(params[:id])
end

get '/dashboard/students/:id/edit' do
  set_page_title(I18n.t('students.page_titles.edit_student'))
  @student = Student.find(params[:id])
  erb :'students/edit_student', user_layout
end

put '/dashboard/students/:id/edit' do
  edit_student(params[:id])
end

get '/dashboard/students/:id/grades' do
  set_page_title(I18n.t('grades.page_titles.grades'))
  @student = Student.find(params[:id])
  @grades = Grade.where(student_id: params[:id]).includes(:section).page(params[:page])
  erb :'grades/grades', user_layout
end
