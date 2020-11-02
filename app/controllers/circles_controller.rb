class CirclesController < ApplicationController
  def new
    @circle = Circle.new
  end

  def index
    @circles = current_user.circles
  end

  def show
    @circle = Circle.find(params[:id])
    @invitation = Invitation.new
    @users = User.pluck(:pseudo).sort
    @news = new_of_circle
  end

  def create
    @circle = Circle.new(circle_params)
    if @circle.save!
      m = Membership.new
      m.circle = @circle
      m.user = current_user
      m.save!
      redirect_to circle_path(@circle)
    else
      redirect_to circles_path, notice: "Oops, merci de recommencer"
    end
  end

  private

  def circle_params
    params.require(:circle).permit(:name, :description)
  end

  def new_of_circle(circle)
    Notification.where(circle_id: circle.id).sort_by(&:created_at).reverse!.last(3)
  end
end
