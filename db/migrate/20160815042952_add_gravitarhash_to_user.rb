class AddGravitarhashToUser < ActiveRecord::Migration
  def change
    add_column :users, :gravitarhash, :string
  end
end
