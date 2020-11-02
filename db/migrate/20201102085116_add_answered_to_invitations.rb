class AddAnsweredToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :answered, :boolean, default: false
  end
end
