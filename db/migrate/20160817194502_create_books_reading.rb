class CreateBooksReading < ActiveRecord::Migration
  def change
    create_table :books_readings do |t|
      t.integer  "isbn",       limit: 8
      t.string   "googleid"
      t.string   "category"
      t.datetime "created_at",           null: false
      t.datetime "updated_at",           null: false
      t.string   "apiLink"
      t.string   "title"
      t.integer  "user_id", index: true
    end
  end
end
