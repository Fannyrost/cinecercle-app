class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # sign_in_and_redirect @user


    if @user.persisted?
          sign_in @user, event: :authentication #this will throw if @user is not activated
          redirect_to root_path
    else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_path
    end

  end
end
