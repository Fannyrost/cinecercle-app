class WatchlistsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create

  def destroy
    @watchlist = Watchlist.find_by(movie_id: params[:movie_id], user_id: current_user.id)
    @watchlist.delete
    redirect_to request.referer, notice: 'Supprimé de votre watchlist ! 👌'
  end

  def create
    @watchlist = Watchlist.find_by(movie_id: params[:movie_id], user_id: current_user.id )
    if @watchlist.nil?
      @watchlist = Watchlist.new(movie_id: params[:movie_id])
      @watchlist.user = current_user
      @watchlist.save!
      @movie = @watchlist.movie
      redirect_to movie_path(@movie), notice: 'Ajouté à votre watchlist ! 👌'
    else
      redirect_to request.referer, notice: 'Déjà dans votre watchlist ! 🙄'
    end
  end

end
