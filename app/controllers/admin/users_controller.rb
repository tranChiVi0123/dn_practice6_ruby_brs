class Admin::UsersController < ApplicationController
  before_action :signed_in_user, except: [:new, :create]
  before_action :is_admin?, only: [:index, :destroy]
  before_action :check_role, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
    @custom_renderer = Class.new(WillPaginate::ActionView::LinkRenderer) do
      def container_attributes
        {class: :digg_pagination}
      end
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
    @locale = params[:locale]
  end

  def update
    @user = User.find_by(id: params[:id])
    u = {name: params[:user][:name],
         email: params[:user][:email],
         role: params[:user][:role] == "true" && 1 || 0,
         password: params[:user][:password]}
    if @user.update(u)
      flash[:success] = I18n.t(:message_successed)
      redirect_to admin_users_url
    else
      flash.now[:danger] = I18n.t(:message_failed)
      render :edit
    end
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

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = I18n.t(:message_successed)
    redirect_to admin_users_url
  end

  private
  def user_params
    params.required(:user).permit(:name, :email, :password,
                                  :password_confirmation)
  end

  def signed_in_user
    if signed_in?
      flash[:danger] = I18n.t(:please_login)
      redirect_to signin_url
    end
  end

  def is_admin?
    p current_user.admin?
    redirect_to root_url unless current_user.admin?
  end

  def check_role
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless current_user?(@user) || current_user.admin?
  end
end
