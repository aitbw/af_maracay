def create_new_student
  new_student = Student.new(params[:student])

  if new_student.save
    flash[:notice] = I18n.t('students.messages.success.created_student')
    redirect '/dashboard/students'
  else
    flash[:errors] = new_student.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

def delete_student(id)
  if Student.destroy(id)
    flash[:notice] = I18n.t('students.messages.success.deleted_student')
    redirect '/dashboard/students'
  else
    flash[:error] = I18n.t('students.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end

def edit_student(id)
  edit_student = Student.find(id)

  if edit_student.update(params[:student])
    flash[:notice] = I18n.t('students.messages.success.updated_student')
    redirect '/dashboard/students'
  else
    flash[:errors] = edit_student.errors.full_messages
    redirect(request.path_info.to_s)
  end
end
