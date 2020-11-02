class Circle < ApplicationRecord
  has_many :recommendations
  has_many :memberships
  has_many :users, through: :memberships
  has_many :invitations

  def prefered_genres
    prefered_genres = []
    self.recommendations.each do |reco|
      reco.movie.split_genre.each do |genre|
        prefered_genres << genre
      end
    end
    five_prefered_genres(prefered_genres)
  end

  private

  def five_prefered_genres(prefered_genres)
    hash = {}
    prefered_genres.each do |value|
      hash.has_key?(value) ? hash[value] += 1 : hash[value] = 1
    end
    arrays = hash.sort_by{|k,v| v}.last(5).reverse!
    five_prefered_genres = []
    arrays.each do |array|
      five_prefered_genres << array[0]
    end
    five_prefered_genres
  end
end
