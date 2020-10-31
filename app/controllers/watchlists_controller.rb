class WatchlistsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  def new
  end

  def create
    @watchlist = Watchlist.new(movie_id: params[:movie_id])
    @watchlist.user = current_user
    @watchlist.save!
    @movie = @watchlist.movie
    redirect_to movie_path(@movie), notice: 'Ajouté à votre watchlist !'
  end

end
