class AddIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :api_key, unique: true
  end
end
