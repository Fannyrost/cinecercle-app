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

  def accept
    @invitation           = Invitation.find(params[:id])
    @invitation.accepted  = true
    @invitation.answered  = true
    @membership           = Membership.new(
                            user_id: @invitation.recipient_id,
                            circle_id: @invitation.circle_id,
                            active: true)
    @membership.save!
    notify_members_from_new_member(@membership)
    if @invitation.save!
      redirect_to request.referer, notice: "Bienvenue dans #{@invitation.circle.name} ! 👋"
    else
      redirect_to request.referer, notice: "Oops, merci de recommencer 🙈"
    end
  end

  def decline
    @invitation = Invitation.find(params[:id])
    @invitation.accepted = false
    @invitation.answered = true
    if @invitation.save!
      redirect_to request.referer
    else
      redirect_to request.referer, notice: "Oops, merci de recommencer 🙈"
    end
  end


  def create_invite_from_user(user, circle)
    if user.nil?
      redirect_to circle_path(@circle), notice: "L'utilisateur n'existe pas, invitez le par mail 😉"
    elsif user.circles.include?(circle)
      redirect_to circle_path(@circle), notice: "#{user.name.capitalize} est déjà membre du cercle 😉"
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

  def notify_members_from_new_member(membership)
    circle = membership.circle
    circle.memberships.each do |member|
      unless member.user == membership.user
        n = Notification.new
        n.sender_id = membership.user.id
        n.recipient_id = member.id
        n.subject = "new-member-in-circle"
        n.object[:membership_id] = membership.id
        n.circle_id = circle.id
        n.save!
      end
    end
  end

  def notify_sender_from_acceptation(invitation)
    circle = invitation.circle
    n = Notification.new
    n.sender_id = invitation.recipient_id
    n.recipient_id = invitation.sender_id
    n.subject = "accepted-invitation"
    n.object[:user_id] =invitation.recipient_id
    n.circle_id = circle.id
    n.save!
  end
end
