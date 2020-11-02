class WatchlistsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  def destroy
    if params[:movie_id].nil?
      @circle = Circle.find(params[:circle_id])
      @recommendation = Recommendation.find(params[:recommendation_id])
      @movie = @recommendation.movie
    else
      @movie = Movie.find(params[:movie_id])
    end
    @watchlist = Watchlist.find_by(movie_id: @movie.id, user_id: current_user.id)
    @watchlist.delete
    redirect_to request.referer, notice: 'Supprimé de votre watchlist ! 👌'
  end

  def create
    if params[:movie_id].nil?
      @circle = Circle.find(params[:circle_id])
      @recommendation = Recommendation.find(params[:recommendation_id])
      create_watchlist_from_circle(@circle, @recommendation)
    else
      @movie = Movie.find(params[:movie_id])
      create_watchlist_from_movie(@movie)
    end
  end

  def create_watchlist_from_movie(movie)
    @watchlist = Watchlist.find_by(movie_id: movie.id, user_id: current_user.id )
    if @watchlist.nil?
      @watchlist = Watchlist.new(movie_id: movie.id)
      @watchlist.user = current_user
      @watchlist.save!
      redirect_to movie_path(movie), notice: 'Ajouté à votre watchlist ! 👌'
    else
      redirect_to request.referer, notice: 'Déjà dans votre watchlist ! 🙄'
    end
  end

  def create_watchlist_from_circle(circle, recommendation)
    @movie = recommendation.movie
    @watchlist = Watchlist.find_by(movie_id: @movie.id, user_id: current_user.id )
    if @watchlist.nil?
      @watchlist = Watchlist.new(movie_id: @movie.id)
      @watchlist.user = current_user
      @watchlist.save!
      redirect_to circle_recommendation_path(circle, recommendation), notice: 'Ajouté à votre watchlist ! 👌'
    else
      redirect_to request.referer, notice: 'Déjà dans votre watchlist ! 🙄'
    end
  end
end
