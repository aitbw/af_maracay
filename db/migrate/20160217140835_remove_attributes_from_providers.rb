class RemoveAttributesFromProviders < ActiveRecord::Migration
  def change
    change_table :providers do |t|
      t.remove :provider_address
    end
  end
end
