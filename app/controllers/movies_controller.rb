class MoviesController < ApplicationController
   skip_before_action :verify_authenticity_token, only: [:search]
  def search
    query = params[:query]
    capitalized_query = query.split.map(&:capitalize).join(' ')
    @movie = Movie.find_by(title: capitalized_query)
    if @movie.nil?
      results = movies_scrapper(query)
      if results.nil?
        redirect_to request.referer, notice: "Aucun résultat 🙄"
      else
        @movies = results
      end
    else
      redirect_to movie_path(@movie)
    end
  end

  def movie
    @imdbid = params[:imdbid]
    @movie = Movie.from_imdbid(@imdbid)
    redirect_to movie_path(@movie)
  end

  def show
    @movie = Movie.find(params[:id])
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
