require "json"

class Admin::ResponsesController < ApplicationController
  before_action :signed_in_user
  before_action :is_admin?

  def index
    @requests = Request.order(status: :asc).paginate(page: params[:page], per_page: 5)
  end

  def accept
    @req = Request.find_by(id: params[:id])
    @book = JSON(@req.request_content, object_class: Book)
    @b = Book.new(
      title: @book.title,
      author: @book.author,
      category_id: @book.category_id,
      image: @book.image,
      published_time: @book.published_time,
      page_num: @book.page_num,
      description: @book.description
    )
    @req.update(status: 1)
    if @b.save
      flash[:success] = I18n.t(:message_successed)
      @noti = Notification.create!(user_id: @req.user.id,
                                  book_id: @b.id,
                                  content: "'#{@book.title}' had added library")
      ActionCable.server.broadcast "comments_channel",
                                   type: :notification,
                                   user_id: @req.user.id,
                                   noti_id: @noti.id,
                                   content: @noti.content
    end
  end

  private
  def signed_in_user
    if signed_in?
      flash[:danger] = I18n.t(:please_login)
      redirect_to signin_url
    end
  end

  def is_admin?
    redirect_to root_url unless current_user.admin?
  end

  def check_role
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless current_user?(@user) || current_user.admin?
  end
end
