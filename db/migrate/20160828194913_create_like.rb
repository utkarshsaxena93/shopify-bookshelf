class CreateLike < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer  "user_id"
      t.integer  "story_id", index: true
    end
  end
end
