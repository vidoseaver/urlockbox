class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    return password_mismatch_error unless passwords_match?
    return create_user_and_go_to_dashboard if @user.save
    flash[:failure] = "That email has already been taken"
    redirect_to new_user_path
  end


  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def passwords_match?
     user_params["password"] === params["user"]["password_confirmation"] ? true : false
    end

    def password_mismatch_error
      flash[:failure] = "The passwords you entered mismatched"
      redirect_to new_user_path
    end

    def create_user_and_go_to_dashboard
      session[:user_id] = @user.id
      redirect_to links_path
    end


end
