class ChangeColumnNullabilityInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :photo, :string, null: true
  end
end
