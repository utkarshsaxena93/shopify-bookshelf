class DropUserBooks < ActiveRecord::Migration
  def change
    drop_table :user_books
  end
end
