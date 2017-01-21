get '/dashboard/providers' do
  set_page_title(I18n.t('providers.page_titles.providers'))
  @providers = Provider.search_provider(params[:provider_name]).page(params[:page])
  erb :'providers/providers', layout: :'layouts/main'
end

get '/dashboard/providers/new_provider' do
  set_page_title(I18n.t('providers.page_titles.new_provider'))
  erb :'providers/new_provider', layout: :'layouts/main'
end

post '/dashboard/providers/new_provider' do
  new_provider
end

get '/dashboard/providers/:id/edit' do
  set_page_title(I18n.t('providers.page_titles.edit_provider'))
  @provider = Provider.find(params[:id])
  erb :'providers/edit_provider', layout: :'layouts/main'
end

put '/dashboard/providers/:id/edit' do
  edit_provider = Provider.find(params[:id])
  edit_existing_provider(edit_provider)
end

get '/dashboard/providers/:id/delete' do
  set_page_title(I18n.t('providers.page_titles.delete_provider'))
  @provider = Provider.find(params[:id])
  erb :'providers/delete_provider', layout: :'layouts/main'
end

delete '/dashboard/providers/:id/delete' do
  delete_provider
end
