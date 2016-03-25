get '/dashboard/providers' do
  set_page_title('Proveedores')
  @providers = Provider.all
  erb :providers, user_layout
end

get '/dashboard/providers/new_provider' do
  set_page_title('Nuevo proveedor')
  erb :'new/new_provider', user_layout
end

post '/dashboard/providers/new_provider' do
  new_provider
end

get '/dashboard/providers/:id/edit' do
  set_page_title('Editar proveedor')
  @provider = Provider.find(params[:id])
  erb :'edit/edit_provider', user_layout
end

put '/dashboard/providers/:id/edit' do
  edit_provider
end

get '/dashboard/providers/:id/delete' do
  set_page_title('Eliminar proveedor')
  @provider = Provider.find(params[:id])
  erb :'delete/delete_provider', user_layout
end

delete '/dashboard/providers/:id/delete' do
  delete_provider
end
