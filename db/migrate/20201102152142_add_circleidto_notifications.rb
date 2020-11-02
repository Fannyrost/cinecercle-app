class AddCircleidtoNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :circle_id, :integer
  end
end
