class AddUserIdIndexToBooksRead < ActiveRecord::Migration
  def change
    add_index  :books_reads, :user_id
  end
end
