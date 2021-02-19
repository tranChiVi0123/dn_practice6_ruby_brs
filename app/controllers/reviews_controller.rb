class ReviewsController < ApplicationController
  before_action :signed_in_user, only: [:comment, :reply]
  before_action :correct_user, only: []
  def index
    @reviews = Review.order(created_at: :asc)
                     .paginate page: params[:page], per_page: 20
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @review = Review.find_by(id: params[:id])
    @categories = Category.all
  end

  def comment
    cmt = current_user.comments.create!(user_id: current_user.id,
                                        review_id: params[:review_id],
                                        comment_content: params[:content])
    if cmt
      ActionCable.server.broadcast "comments_channel",
                                   content:  params[:content],
                                   user_id: current_user.id,
                                   user_name: current_user.name,
                                   review_id: params[:review_id],
                                   comment_id: cmt.id
    end
  end

  def reply
    rep = current_user.replies.create!(user_id: current_user.id,
                                      comment_id: params[:comment_id],
                                      reply_content: params[:content_reply])
    if rep
      ActionCable.server.broadcast "reply_channel",
                                   content: params[:content_reply],
                                   comment_id: rep.comment.id,
                                   user_id: rep.user.id,
                                   user_name: rep.user.name
    end
  end

  private
  def signed_in_user
    if signed_in?
      flash[:danger] = I18n.t(:please_log_in)
      redirect_to signin_path
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
