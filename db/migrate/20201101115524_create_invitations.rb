class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.boolean :accepted, default: false
      t.references :circle, null: false, foreign_key: true
      t.integer :sender_id
      t.integer :recipient_id, null: true
      t.string :token
      t.string :email

      t.timestamps
    end
  end
end
