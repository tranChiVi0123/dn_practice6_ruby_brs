class BooksController < ApplicationController
  def index
    @books = Book.order(created_at: :asc)
                 .paginate page: params[:page], per_page: 20
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @book = Book.find_by(id: params[:id])
    @categories = Category.all
  end
end
