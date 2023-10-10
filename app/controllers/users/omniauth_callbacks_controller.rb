class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
  skip_before_action :verify_authenticity_token, only: [:facebook, :developer]

  def developer
    sign_in_and_redirect User.system_user
  end

  def google_oauth2
    binding.pry
    @user = User.from_omniauth(omniauth_params)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = omniauth_params.except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url
    end

  end


  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(omniauth_params)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = omniauth_params.except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url
    end
  end


  def omniauth_params
    request.env["omniauth.auth"]
  end

end
