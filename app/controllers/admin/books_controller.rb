class Admin::BooksController < ApplicationController
  include Admin::BooksHelper

  before_action :signed_in_user, except: [:new, :create]
  before_action :is_admin?, only: [:index, :destroy]
  before_action :check_role, only: [:edit, :update]

  def index
    @books = Book.paginate(page: params[:page], per_page: 10)
    @custom_renderer = Class.new(WillPaginate::ActionView::LinkRenderer) do
      def container_attributes
        {class: :digg_pagination}
      end
    end
  end

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
    if @book.save
      flash[:success] = I18n.t(:message_successed)
      upload_img book_params[:image], @book.image if book_params[:image]
      redirect_to admin_books_url
    else
      flash.now[:danger] = I18n.t(:message_failed)
      render :new
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
    @categories = Category.all.map{|cat| [cat.name, cat.id]}
  end

  def update
    @book = Book.find_by(id: params[:id])
    b = book_params
    if book_params[:published_time]
      b[:published_time] = convert_date book_params[:published_time]
    end
    if book_params[:image]
      b[:image] = random_last_name_img book_params[:image]
                  .original_filename
    end
    if @book.update(b)
      flash[:success] = I18n.t(:message_successed)
      upload_img book_params[:image], @book.image if book_params[:image]
      redirect_to admin_books_url
    else
      flash.now[:danger] = I18n.t(:message_failed)
      render :edit
    end
  end

  def destroy
    Book.find_by(id: params[:id]).destroy
    flash.now[:success] = I18n.t(:message_successed)
    redirect_to admin_books_url
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

  def is_admin?
    p current_user.admin?
    redirect_to root_url unless current_user.admin?
  end

  def check_role
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless current_user?(@user) || current_user.admin?
  end
end
