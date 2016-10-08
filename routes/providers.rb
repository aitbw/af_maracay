get '/dashboard/providers' do
  set_page_title('Proveedores')
  @providers = Provider.search_provider(params[:provider_name]).page(params[:page])
  erb :'providers/providers', user_layout
end

get '/dashboard/providers/new_provider' do
  set_page_title('Nuevo proveedor')
  erb :'providers/new_provider', user_layout
end

post '/dashboard/providers/new_provider' do
  new_provider
end

get '/dashboard/providers/:id/edit' do
  set_page_title('Editar proveedor')
  @provider = Provider.find(params[:id])
  erb :'providers/edit_provider', user_layout
end

put '/dashboard/providers/:id/edit' do
  edit_provider
end

get '/dashboard/providers/:id/delete' do
  set_page_title('Eliminar proveedor')
  @provider = Provider.find(params[:id])
  erb :'providers/delete_provider', user_layout
end

delete '/dashboard/providers/:id/delete' do
  delete_provider
end
