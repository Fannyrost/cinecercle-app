class MoviesController < ApplicationController
   skip_before_action :verify_authenticity_token, only: [:search]
  def search
    query = params[:query]
    @movie = Movie.find_by(title: query)
    if @movie.nil?
      @movies = scrapper(query)
    else
      redirect_to movie_path(@movie)
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  private

  def scrapper(query)
    key = "ce8d3236"
    url = "https://www.omdbapi.com/?s=#{query}&apikey=#{key}"
    response = RestClient.get(url)
    results = JSON.parse(response)

  end

end
