def new_provider
  new_provider = Provider.new(params[:provider])

  if new_provider.save
    flash[:notice] = I18n.t('providers.messages.success.created_provider')
    redirect '/dashboard/providers'
  else
    flash[:errors] = new_provider.errors
    redirect(request.path_info.to_s)
  end
end

def edit_existing_provider(edit_provider)
  if edit_provider.update(params[:provider])
    flash[:notice] = I18n.t('providers.messages.success.updated_provider')
    redirect '/dashboard/providers'
  else
    flash[:errors] = edit_provider.errors
    redirect(request.path_info.to_s)
  end
end

def delete_provider
  if Provider.destroy(params[:id])
    flash[:notice] = I18n.t('providers.messages.success.deleted_provider')
    redirect '/dashboard/providers'
  else
    flash[:error] = I18n.t('providers.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end
