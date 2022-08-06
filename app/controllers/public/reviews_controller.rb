class Public::ReviewsController < ApplicationController

  def new
     @book = RakutenWebService::Books::Book.search(isbn: params[:id])
     @review = Review.new
  end

  def create
    @review=Review.new(review_params)
    if @review.save!

    redirect_to "/public/books/#{ @review.book_id }"
    else
      #binding.pry

      @book = RakutenWebService::Books::Book.search(isbn: params[:id])
      @review = Review.new
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @book = RakutenWebService::Books::Book.search(isbn: @review.book_id)
  end

  private
  def review_params
     params.require(:review).permit(:title, :body, :assess, :created_at, :book_id, :user_id ,:updated_at)
  end

end
