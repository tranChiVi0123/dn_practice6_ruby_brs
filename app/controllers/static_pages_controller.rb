class StaticPagesController < ApplicationController
  def home
    @reviews = Review.order(created_at: :asc)
                     .paginate page: params[:page], per_page: 10
    respond_to do |format|
      format.html
      format.js
    end
  end
end
