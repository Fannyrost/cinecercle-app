class CreateRecommendations < ActiveRecord::Migration[6.0]
  def change
    create_table :recommendations do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :circle, null: false, foreign_key: true
      t.references :membership, null: false, foreign_key: true
      t.integer :rating
      t.string :review

      t.timestamps
    end
  end
end
