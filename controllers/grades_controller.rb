def batch_grade_assignment(course)
  ActiveRecord::Base.transaction do
    if Grade.create(params[:grade])
      course.update(grades_assigned: true)
      flash[:notice] = I18n.t('grades.messages.success.assigned_grades')
      redirect '/dashboard/courses'
    else
      flash[:error] = I18n.t('grades.messages.errors.failed_transaction')
      redirect(request.path_info.to_s)
    end
  end
end

def edit_grade; end
