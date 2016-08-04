class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :isbn
      t.string :googleid
      t.string :category

      t.timestamps null: false
    end
  end
end
