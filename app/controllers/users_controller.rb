class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @watchlists             = @user.movies
  end

  def profile
    @user                   = current_user
    @unsanwered_invitations = Invitation.where(recipient_id: @user.id, answered: false)
    @watchlists             = @user.movies
  end


end
