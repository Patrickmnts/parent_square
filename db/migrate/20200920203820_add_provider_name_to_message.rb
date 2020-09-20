class AddProviderNameToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :provider_name, :string
  end
end
