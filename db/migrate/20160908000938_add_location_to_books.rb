class AddLocationToBooks < ActiveRecord::Migration
  def change
    add_column :books, :location, :string
  end
end
