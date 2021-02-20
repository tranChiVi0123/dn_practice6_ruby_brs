class RelationshipsController < ApplicationController
  def create
    p "ASSAASAS"
    user = User.find(params[:followed_id])
    current_user.follow(user)
    render json: {result: :OK}
  end

  def destroy
    p "DSDSDDAD"
    p params
    user = User.find(params[:followed_id])
    current_user.unfollow(user)
    render json: {result: :OK}
  end
end
