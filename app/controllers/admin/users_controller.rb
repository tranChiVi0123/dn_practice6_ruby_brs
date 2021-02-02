class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = I18n.t(:message_successed)
      redirect_to root_url
    else
      flash.now[:danger] = I18n.t(:message_failed)
      render :new
    end
  end

  private

  def user_params
    p params
    params.required(:user).permit(:name, :email, :password,
                                  :password_confirmation)
  end
end
