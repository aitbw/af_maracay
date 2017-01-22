def new_bank_account(new_account)
  if new_account.save
    flash[:notice] = I18n.t(
      'bank_accounts.messages.success.created_bank_account'
    )
    redirect "/dashboard/teachers/#{params[:id]}/bank_accounts"
  else
    flash[:errors] = new_account.errors
    redirect(request.path_info.to_s)
  end
end

def delete_bank_account
  if BankAccount.destroy(params[:account])
    flash[:notice] = I18n.t(
      'bank_accounts.messages.success.deleted_bank_account'
    )
    redirect "/dashboard/teachers/#{params[:teacher]}/bank_accounts"
  else
    flash[:error] = I18n.t('bank_accounts.messages.errors.failed_transaction')
    redirect(request.path_info.to_s)
  end
end

def edit_bank_account(edit_account, account_id)
  if edit_account.update(params[:form])
    flash[:notice] = I18n.t(
      'bank_accounts.messages.success.updated_bank_account'
    )
    redirect "/dashboard/teachers/#{account_id}/bank_accounts"
  else
    flash[:errors] = edit_account.errors
    redirect(request.path_info.to_s)
  end
end
