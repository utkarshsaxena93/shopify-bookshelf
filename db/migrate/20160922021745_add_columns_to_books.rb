class AddColumnsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :publisher, :string
    add_column :books, :publishedDate, :string
    add_column :books, :author, :string
    add_column :books, :averageRating, :integer
    add_column :books, :ratingsCount, :integer
    add_column :books, :description, :string
    add_column :books, :imageurl, :string
  end
end
