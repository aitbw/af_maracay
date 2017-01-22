def new_teacher
  new_teacher = Teacher.new(params[:teacher])

  if new_teacher.save
    flash[:notice] = I18n.t('teachers.messages.success.created_teacher')
    redirect '/dashboard/teachers'
  else
    flash[:errors] = new_teacher.errors
    redirect(request.path_info.to_s)
  end
end

def delete_teacher(id)
  if Teacher.destroy(id)
    flash[:notice] = I18n.t('teachers.messages.success.deleted_teacher')
    redirect '/dashboard/teachers'
  else
    flash[:error] = I18n.t('teachers.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end

def edit_teacher(id)
  edit_teacher = Teacher.find(id)

  if edit_teacher.update(params[:teacher])
    flash[:notice] = I18n.t('teachers.messages.success.updated_teacher')
    redirect '/dashboard/teachers'
  else
    flash[:errors] = edit_teacher.errors
    redirect(request.path_info.to_s)
  end
end
