class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.string :subject
      t.json :object, default: {}

      t.timestamps
    end
  end
end
