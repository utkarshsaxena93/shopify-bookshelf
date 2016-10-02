class RemoveDeviseInvitableMoreColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :invited_by_id
    remove_column :users, :invitations_count
  end
end
