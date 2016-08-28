class AddLikedByToStories < ActiveRecord::Migration
  def change
    add_column :stories, :likedBy, :string, array: true, default: []
  end
end
