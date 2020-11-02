class MoviesController < ApplicationController
   skip_before_action :verify_authenticity_token, only: [:search]

  def search
    query = params[:query]
    if query.nil?
      @circle = Circle.find(params[:circle_id])
      search_display_from_circle(@circle)
    else
      search_display_from_query(query)
    end

  end

  def movie
    @imdbid = params[:imdbid]
    @movie = Movie.from_imdbid(@imdbid)
    redirect_to movie_path(@movie)
  end

  def show
    @movie = Movie.find(params[:id])
    unless cookies[:circle_id].nil? || cookies[:circle_id] == ""
      @circle = Circle.find(cookies[:circle_id])
    end
    @recommendation = Recommendation.new
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

  def search_display_from_query(query)
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

  def search_display_from_circle(circle)
    @movies = nil
    cookies[:circle_id] = circle.id
  end
end
