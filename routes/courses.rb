get '/dashboard/courses' do
  set_page_title(I18n.t('courses.page_titles.courses'))
  @courses = Course.search_course(params[:code]).page(params[:page]).includes(:course_type, :office)
  @course_types = CourseType.all
  erb :'courses/courses', layout: :'layouts/main'
end

get '/dashboard/courses/new_course' do
  set_page_title(I18n.t('courses.page_titles.new_course'))
  @types = CourseType.select(:course_type_id, :course_modality)
  @offices = Office.all
  erb :'courses/new_course', layout: :'layouts/main'
end

post '/dashboard/courses/new_course' do
  new_course
end

get '/dashboard/courses/:id/delete' do
  set_page_title(I18n.t('courses.page_titles.delete_course'))
  @course = Course.find(params[:id])
  erb :'courses/delete_course', layout: :'layouts/main'
end

delete '/dashboard/courses/:id/delete' do
  delete_course(params[:id])
end

get '/dashboard/courses/:id/edit' do
  set_page_title(I18n.t('courses.page_titles.edit_course'))
  @course = Course.find(params[:id])
  @types = CourseType.all
  @offices = Office.all
  erb :'courses/edit_course', layout: :'layouts/main'
end

put '/dashboard/courses/:id/edit' do
  edit_course(params[:id])
end

get '/dashboard/courses/:id/grades/assign' do
  set_page_title(I18n.t('grades.page_titles.assign_grades'))
  @course = Course.find(params[:id])
  erb :'grades/assign_grades', layout: :'layouts/main'
end

post '/dashboard/courses/:id/grades/assign' do
  course = Course.find(params[:id])
  batch_grade_assignment(course)
end
