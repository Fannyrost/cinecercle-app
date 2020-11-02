class RecommendationsController < ApplicationController

  def create
    @recommendation       = Recommendation.new(recommendation_params)
    @movie                = Movie.find(params[:movie_id])
    @recommendation.movie = @movie

    unless cookies[:circle_id].nil?
      @circle                = Circle.find(cookies[:circle_id])
      @recommendation.circle = @circle
      cookies[:circle_id]    = nil
    end

    @membership = Membership.find_by(user_id: current_user.id, circle_id: @circle.id )
    @recommendation.membership = @membership
    if @recommendation.save!
      notify_members_from_new_reco(@recommendation)
      redirect_to circle_recommendation_path(@circle, @recommendation)
    else
      redirect_to movie_path(@movie), notice: 'Oops, merci de réessayer 🙄'
    end
  end

  def show
    @recommendation = Recommendation.find(params[:id])
    @movie          = @recommendation.movie
    @circle         = @recommendation.circle
  end

  def recommendation_params
    params.require(:recommendation).permit(:rating, :review)
  end

  private

  def notify_members_from_new_reco(recommendation)
    circle = recommendation.circle
    circle.memberships.each do |member|
      unless member.user == current_user
        n = Notification.new
        n.sender_id = current_user.id
        n.recipient_id = member.id
        n.subject = "new-reco-in-circle"
        n.object[:recommendation_id] = recommendation.id
        n.object[:circle_id] = circle.id
        n.save!
      end
    end
  end
end
