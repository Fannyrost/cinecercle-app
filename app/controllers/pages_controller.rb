class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    unless user_signed_in?
      redirect_to new_user_session_path
    end

    @news = news
  end

  def news
    Notification.where(recipient_id: current_user.id).sort_by(&:created_at).reverse!.last(20)
  end
end
