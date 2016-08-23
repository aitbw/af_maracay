class AcceptNullDatesOnPayments < ActiveRecord::Migration
  def change
    change_column_null :payments, :issue_date, true
    change_column_null :payments, :expiration_date, true
  end
end
