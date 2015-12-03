# Helper to keep exception handling DRY
def find_provider(id)
  Provider.find(id).present?
rescue ActiveRecord::RecordNotFound
  redirect '/dashboard/providers', error: 'El proveedor no existe.'
end

before %r{\/dashboard\/providers\/(\d)\/(delete|edit)} do |id, _|
  find_provider(id)
end

def new_provider
  new_provider = Provider.new(params[:provider])

  if new_provider.save
    redirect '/dashboard/providers', notice: 'Proveedor creado exitosamente.'
  else
    flash[:errors] = new_provider.errors.full_messages
    redirect "#{request.path_info}"
  end
end

def edit_provider
  edit_provider = Provider.find(params[:id])

  if edit_provider.update(params[:provider])
    redirect '/dashboard/providers', notice: 'Datos actualizados.'
  else
    flash[:errors] = edit_provider.errors.full_messages
    redirect "#{request.path_info}"
  end
end

def delete_provider
  if Provider.destroy(params[:id])
    redirect '/dashboard/providers', notice: 'Proveedor eliminado.'
  else
    flash[:error] = 'Ha ocurrido un error, intente nuevamente.'
    redirect "#{request.path_info}"
  end
end
