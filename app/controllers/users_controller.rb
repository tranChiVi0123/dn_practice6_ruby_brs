class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find_by(id: params[:id])
    @locale = params[:locale]
    @reviews = @user.reviews.paginate(page: params[:page])
  end

  def following
    @title = t "following"
    @user = User.find(params[:id])
    @locale = params[:locale]
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = t "follower"
    @user = User.find(params[:id])
    @locale = params[:locale]
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end
end
