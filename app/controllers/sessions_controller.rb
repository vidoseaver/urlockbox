class SessionsController < ApplicationController
  protect_from_forgery except: [:create, :new]

  def new
  end

  def create
    return incorrect_email_error  unless @user = User.find_by(email: params["email"])
    return incorrect_password_error unless @user.authenticate(params["password"])
    session[:user_id] = @user.id
    flash[:sucesss] = "Welcome #{@user.email}"
    redirect_to links_path
  end

  def destroy
    session.clear
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end

  private
    def incorrect_password_error
      flash[:warning] = "Incorrect password"
      redirect_to new_session_path
    end

    def incorrect_email_error
      flash[:warning] = "Incorrect email"
      redirect_to new_session_path
    end
end
