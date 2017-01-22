get '/dashboard/courses/:id/sections' do
  @course_code = Course.where(course_id: params[:id]).pluck(:course_code).first
  set_page_title(
    I18n.t(
      'sections.page_titles.course_sections',
      course_code: @course_code
    )
  )

  @sections = Section.where(course_id: params[:id]).page(params[:page]).includes(:level)
  erb :'sections/sections', layout: :'layouts/main'
end

get '/dashboard/courses/:course/sections/:section/students/show' do
  @section = Section.find(params[:section])
  set_page_title(
    I18n.t(
      'sections.page_titles.section_students',
      level: @section.level_description
    )
  )

  @section_students = Student.where(section_id: params[:section]).page(params[:page])
  erb :'sections/section_students', layout: :'layouts/main'
end

get '/dashboard/courses/:course/sections/:section/grades' do
  set_page_title(I18n.t('grades.page_titles.grades'))
  @section = Section.find(params[:section])
  @grades = Grade.where(section_id: params[:section]).includes(:student).page(params[:page])
  erb :'sections/section_grades', layout: :'layouts/main'
end

get '/dashboard/courses/:id/sections/new' do
  set_page_title(I18n.t('sections.page_titles.new_section'))
  @levels = Level.all
  erb :'sections/new_section', layout: :'layouts/main'
end

post '/dashboard/courses/:id/sections/new' do
  @course = Course.find(params[:id])
  new_section = @course.sections.create(params[:section])

  if new_section.save
    flash[:notice] = I18n.t('sections.messages.success.created_section')
    redirect "/dashboard/courses/#{params[:id]}/sections"
  else
    flash[:errors] = new_section.errors
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/courses/:course/sections/:section/delete' do
  set_page_title(I18n.t('sections.page_titles.delete_section'))
  @section = Section.find(params[:section])
  erb :'sections/delete_section', layout: :'layouts/main'
end

delete '/dashboard/courses/:course/sections/:section/delete' do
  if Section.destroy(params[:section])
    flash[:notice] = I18n.t('sections.messages.success.deleted_section')
    redirect "/dashboard/courses/#{params[:course]}/sections"
  else
    flash[:error] = I18n.t('sections.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end

get '/dashboard/courses/:course/sections/:section/edit' do
  set_page_title(I18n.t('sections.page_titles.edit_section'))
  @section = Section.find(params[:section])
  @courses = Course.all
  @levels = Level.all
  erb :'sections/edit_section', layout: :'layouts/main'
end

put '/dashboard/courses/:course/sections/:section/edit' do
  edit_section = Section.find(params[:section])

  if edit_section.update(params[:form])
    flash[:notice] = I18n.t('sections.messages.success.updated_section')
    redirect "/dashboard/courses/#{params[:course]}"
  else
    flash[:errors] = edit_section.errors
    redirect(request.path_info.to_s)
  end
end
