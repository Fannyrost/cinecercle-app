class InvitationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def new
    @invitation = Invitation.new
    @circle = Circle.find(params[:circle_id])
  end

  def create
    @circle = Circle.find(params[:circle_id])
    if params[:invitation].nil?
      @user = User.find_by(pseudo: params[:query])
      create_invite_from_user(@user, @circle)
    else
      create_invite_from_email(@circle)
    end
  end

  def create_invite_from_user(user, circle)
    if user.nil?
      redirect_to circle_path(@circle), notice: "L'utilisateur n'existe pas, invitez le par mail 😉"
    else
      @invitation = Invitation.new(recipient_id: user.id )
      @invitation.circle_id = @circle.id
      @invitation.sender_id = current_user.id
      @invitation.generate_token
      if @invitation.save!
        redirect_to circle_path(@circle), notice: "Invitation envoyée ! 💌 "
      else
        redirect_to request.referer, notice: "Oops, merci de recommencer 🙈"
      end
    end
  end


  def create_invite_from_email(circle)
    @invitation = Invitation.new(invitation_params)
    @invitation.circle_id = @circle.id
    @invitation.sender_id = current_user.id
    @invitation.generate_token
    if @invitation.save!
      # InvitationMailer.new_user_invite(@invite, new_user_registration_path(invite_token: @invite.token)).deliver
      redirect_to circle_path(@circle), notice: "Invitation envoyée ! 💌 "
    else
      redirect_to request.referer, notice: "Oops, merci de recommencer 🙈"
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email)
  end



end
