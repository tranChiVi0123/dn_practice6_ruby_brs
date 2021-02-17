class ReviewsController < ApplicationController
  def index
    @reviews = Review.order(created_at: :asc)
                     .paginate page: params[:page], per_page: 20
    respond_to do |format|
      format.html
      format.js
    end
  end
end
