class SessionsController < ApplicationController
  def new
    redirect_to root_url unless signed_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = I18n.t(:message_successed_signin)
      redirect_to root_path
    else
      flash[:danger] = I18n.t(:message_failed_signin)
      render :new
    end
  end

  def destroy
    sign_out unless signed_in?
    redirect_to root_url
  end
end
