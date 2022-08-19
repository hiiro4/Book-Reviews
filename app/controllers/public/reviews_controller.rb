class Public::ReviewsController < ApplicationController
  before_action :specified_user, only: [ :destroy]

  def new
     @book = RakutenWebService::Books::Book.search(isbn: params[:id])
     @review = Review.new
  end

  def create
    @review=Review.new(review_params)
    if @review.save
      redirect_to "/public/books/#{ @review.book_id }"
    else
      @book = RakutenWebService::Books::Book.search(isbn: params[:id])
      @review = Review.new
      #byebug
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @book = RakutenWebService::Books::Book.search(isbn: @review.book_id)

  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to  public_books_path
  end

  private
  def review_params
     params.require(:review).permit(:title, :body, :assess, :book_title, :created_at, :book_id, :user_id ,:updated_at)
  end

  def specified_user
    redirect_to public_books_path unless current_user.check == "2"
  end

end
