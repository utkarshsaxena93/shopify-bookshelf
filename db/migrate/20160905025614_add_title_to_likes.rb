class AddTitleToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :title, :string
  end
end
