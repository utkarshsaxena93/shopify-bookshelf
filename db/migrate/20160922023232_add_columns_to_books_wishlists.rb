class AddColumnsToBooksWishlists < ActiveRecord::Migration
  def change
    add_column :books_wishlists, :publisher, :string
    add_column :books_wishlists, :publishedDate, :string
    add_column :books_wishlists, :author, :string
    add_column :books_wishlists, :averageRating, :integer
    add_column :books_wishlists, :ratingsCount, :integer
    add_column :books_wishlists, :description, :string
    add_column :books_wishlists, :imageurl, :string
  end
end
