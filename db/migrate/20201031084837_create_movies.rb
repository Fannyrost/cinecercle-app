class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.string :actors
      t.string :year
      t.string :genre
      t.text :plot

      t.timestamps
    end
  end
end
