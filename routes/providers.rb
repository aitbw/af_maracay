get '/dashboard/providers' do
  set_page_title('Proveedores')
  @providers = Provider.all
  erb :providers, layout: :'layouts/dashboard'
end

get '/dashboard/providers/new_provider' do
  set_page_title('Nuevo proveedor')
  erb :'new/new_provider', layout: :'layouts/dashboard'
end

post '/dashboard/providers/new_provider' do
  new_provider
end

get '/dashboard/providers/:id/edit' do
  set_page_title('Editar proveedor')
  @provider = Provider.find(params[:id])
  erb :'edit/edit_provider', layout: :'layouts/dashboard'
end

put '/dashboard/providers/:id/edit' do
  edit_provider
end

get '/dashboard/providers/:id/delete' do
  set_page_title('Eliminar proveedor')
  @provider = Provider.find(params[:id])
  erb :'delete/delete_provider', layout: :'layouts/dashboard'
end

delete '/dashboard/providers/:id/delete' do
  delete_provider
end
