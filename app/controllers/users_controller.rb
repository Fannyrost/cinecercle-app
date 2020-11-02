class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def profile
    @user                   = current_user
    @unsanwered_invitations = Invitation.where(recipient_id: @user.id, answered: false)
    @status_invitations     = Invitation.where(sender_id: @user.id)
    @watchlists             = @user.movies

  end
end
