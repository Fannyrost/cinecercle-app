class AddImdbToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :imdbid, :string
  end
end
