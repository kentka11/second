class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :emial, unique: true
  end
end
