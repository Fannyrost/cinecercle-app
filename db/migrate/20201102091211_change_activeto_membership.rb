class ChangeActivetoMembership < ActiveRecord::Migration[6.0]
  def change
    change_column :memberships, :active, :boolean, default: true
  end
end
