get '/dashboard/providers' do
  set_page_title(I18n.t('providers.page_titles.providers'))
  @providers = Provider.search_provider(params[:provider_name]).page(params[:page])
  erb :'providers/providers', user_layout
end

get '/dashboard/providers/new_provider' do
  set_page_title(I18n.t('providers.page_titles.new_provider'))
  erb :'providers/new_provider', user_layout
end

post '/dashboard/providers/new_provider' do
  new_provider
end

get '/dashboard/providers/:id/edit' do
  set_page_title(I18n.t('providers.page_titles.edit_provider'))
  @provider = Provider.find(params[:id])
  erb :'providers/edit_provider', user_layout
end

put '/dashboard/providers/:id/edit' do
  edit_provider = Provider.find(params[:id])
  edit_existing_provider(edit_provider)
end

get '/dashboard/providers/:id/delete' do
  set_page_title(I18n.t('providers.page_titles.delete_provider'))
  @provider = Provider.find(params[:id])
  erb :'providers/delete_provider', user_layout
end

delete '/dashboard/providers/:id/delete' do
  delete_provider
end
