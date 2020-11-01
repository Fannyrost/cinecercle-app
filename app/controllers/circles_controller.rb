class CirclesController < ApplicationController
  def new
    @circle = Circle.new
  end

  def index
    @circles = current_user.circles
  end

  def show
    @circle = Circle.find(params[:id])
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

  def circle_params
    params.require(:circle).permit(:name, :description)
  end
end
