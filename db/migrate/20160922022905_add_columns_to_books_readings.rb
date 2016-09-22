class AddColumnsToBooksReadings < ActiveRecord::Migration
  def change
    add_column :books_readings, :publisher, :string
    add_column :books_readings, :publishedDate, :string
    add_column :books_readings, :author, :string
    add_column :books_readings, :averageRating, :integer
    add_column :books_readings, :ratingsCount, :integer
    add_column :books_readings, :description, :string
    add_column :books_readings, :imageurl, :string
  end
end
