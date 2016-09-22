class AddColumnsToBooksReads < ActiveRecord::Migration
  def change
    add_column :books_reads, :publisher, :string
    add_column :books_reads, :publishedDate, :string
    add_column :books_reads, :author, :string
    add_column :books_reads, :averageRating, :integer
    add_column :books_reads, :ratingsCount, :integer
    add_column :books_reads, :description, :string
    add_column :books_reads, :imageurl, :string
  end
end
