class ReviewsController < ApplicationController
  before_action :signed_in_user, only: [:comment, :reply, :new,
                                        :create, :edit, :update]
  before_action :correct_user, only: []

  def index
    @reviews = Review.order(created_at: :desc)
                     .paginate page: params[:page], per_page: 20
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @book = Book.find_by(id: params[:book_id])
    @books = Book.all.map{|b| [b.title, b.id]}
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = I18n.t(:message_successed)
      redirect_to root_path
    else
      flash.now[:danger] = I18n.t(:message_failed)
      render :new
    end
  end

  def edit
    @review = Review.find_by(id: params[:id])
    @books = Book.all.map{|b| [b.title, b.id]}
  end

  def update
    @review = Review.find_by(id: params[:id])
    if @review.update(review_params)
      flash[:success] = I18n.t(:message_successed)
      redirect_to root_path
    else
      flash.now[:danger] = I18n.t(:message_failed)
      render :edit
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

  def review_params
    result = {
      user_id: current_user.id,
      book_id: params[:review][:book_id],
      review_title: params[:review][:review_title],
      review_content: params[:review][:review_content]
    }
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
