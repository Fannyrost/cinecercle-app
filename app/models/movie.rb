class Movie < ApplicationRecord

  def self.from_imdbid(imdbid)
    Movie.find_by(imdbid: imdbid) || create_movie_from(imdbid)
  end

  def self.create_movie_from(imdbid)
    key = "ce8d3236"
    url = "http://www.omdbapi.com/?i=#{imdbid}&apikey=#{key}"
    response = RestClient.get(url)
    movie = JSON.parse(response)
    m = Movie.new(
      imdbid: imdbid,
      title: movie['Title'],
      year: movie['Year'],
      genre: movie['Genre'],
      director: movie['Director'],
      actors: movie['Actors'],
      plot: movie['Plot'],
      poster: movie['Poster']
    )
    m.save!
    m
  end

  def split_genre
    x = genre.split(",")
    x
  end
end
