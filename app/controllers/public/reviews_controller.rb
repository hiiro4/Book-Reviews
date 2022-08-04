class Public::ReviewsController < ApplicationController

  def new
     @book = RakutenWebService::Books::Book.search(isbn: params[:format])
     @review = Review.new
  end

  def create

  end

end
