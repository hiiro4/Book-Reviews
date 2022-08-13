class Public::BooksController < ApplicationController

  def index
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end

  def show
    @book = RakutenWebService::Books::Book.search(isbn: params[:id])
    @reviews = Review.where(book_id: params[:id])
    @averaege = 0
    @count = 0
  end

end
