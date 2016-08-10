class AddApiLinkToBooks < ActiveRecord::Migration
  def change
    add_column :books, :apiLink, :string
  end
end
