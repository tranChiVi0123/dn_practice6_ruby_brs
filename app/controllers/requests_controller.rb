require "json"

class RequestsController < ApplicationController
  include Admin::BooksHelper

  before_action :signed_in_user

  def new
    @book = Book.new
    @categories = Category.all.map{|cat| [cat.name, cat.id]}
  end

  def create
    @book = Book.new(book_params)
    if book_params[:image]
      @book.image = random_last_name_img book_params[:image]
                    .original_filename
    end
    if book_params[:published_time]
      @book.published_time = convert_date book_params[:published_time]
    end
    @request = Request.new(user_id: current_user.id,
                          request_content: @book.to_json)
    if @request.save
      flash[:success] = I18n.t(:message_successed)
      upload_img book_params[:image], @book.image if book_params[:image]
      redirect_to root_url
    else
      flash.now[:danger] = I18n.t(:message_failed)
      render :new
    end
  end

  def seen
    @noti = Notification.find_by(id: params[:id])
    if @noti.update(status: 1)
      @book = Book.find_by(id: @noti.book_id)
      redirect_to book_url(params[:locale], @book)
    end
  end

  private
  def book_params
    params.required(:book).permit(:title, :author, :category_id,
                                  :image, :published_time, :page_num,
                                  :description)
  end

  def signed_in_user
    if signed_in?
      flash[:danger] = I18n.t(:please_login)
      redirect_to signin_url
    end
  end
end
