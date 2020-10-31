class MoviesController < ApplicationController
   skip_before_action :verify_authenticity_token, only: [:search]
  def search
    query = params[:query]
    @movie = Movie.find_by(title: query)
    Movie.find_by(title: query)
    if @movie.nil?
      @movies = movies_scrapper(query)
    else
      redirect_to movie_path(@movie)
    end
  end

  def movie
    @imdbid = params[:imdbid]
    @movie = Movie.from_imdbid(@imdbid)
  end


  private

  def movies_scrapper(query)
    key = "ce8d3236"
    url = "https://www.omdbapi.com/?s=#{query}&apikey=#{key}"
    response = RestClient.get(url)
    results = JSON.parse(response)["Search"]
  end

  def movie_scrapper(imdbid)
    key = "ce8d3236"
    url = "https://www.omdbapi.com/?s=#{query}&apikey=#{key}"
    response = RestClient.get(url)
    results = JSON.parse(response)["Search"]
  end

end
