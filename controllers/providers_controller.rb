def new_provider
  new_provider = Provider.new(params[:provider])

  if new_provider.save
    redirect '/dashboard/providers', notice: 'Proveedor creado exitosamente.'
  else
    flash[:errors] = new_provider.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

def edit_provider
  edit_provider = Provider.find(params[:id])

  if edit_provider.update(params[:provider])
    redirect '/dashboard/providers', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_provider.errors.full_messages
    redirect(request.path_info.to_s)
  end
end

def delete_provider
  if Provider.destroy(params[:id])
    redirect '/dashboard/providers', notice: 'Proveedor eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect(request.path_info.to_s)
  end
end
