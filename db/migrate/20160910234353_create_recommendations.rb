class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer "book_id"
      t.integer "user_id"
      t.string "user_recommendation"
    end
  end
end
