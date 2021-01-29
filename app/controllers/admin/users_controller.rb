class Admin::UsersController < ApplicationController
  def new; end

  def create
    @user = User.new(user_params)
    if @user.save
      # redirect to home
    else
      # show flash error
      flash.now[:danger] = I18n.t(:message_fail)
      render :new
    end
  end

  private

  def user_params
    params.required(:user).permit(:name, :email,
                                  :password_digest, :password_confirmation)
  end
end
