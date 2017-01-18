def new_course
  new_course = Course.new(params[:course])

  if new_course.save
    flash[:notice] = I18n.t('courses.messages.success.created_course')
    redirect '/dashboard/courses'
  else
    flash[:errors] = new_course.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

def delete_course(id)
  if Course.destroy(id)
    flash[:notice] = I18n.t('courses.messages.success.deleted_course')
    redirect '/dashboard/courses'
  else
    flash[:error] = I18n.t('courses.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end

def edit_course(id)
  edit_course = Course.find(id)

  if edit_course.update(params[:course])
    flash[:notice] = I18n.t('courses.messages.success.updated_course')
    redirect '/dashboard/courses'
  else
    flash[:errors] = edit_course.errors.full_messages
    redirect(request.path_info.to_s)
  end
end
