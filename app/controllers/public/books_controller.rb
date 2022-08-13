class Public::BooksController < ApplicationController

  def index
    if params[:search] == "title"
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
      @hit = @books.count
    elsif params[:search] == "author"
      @books = RakutenWebService::Books::Book.search(author: params[:keyword])
      @hit = @books.count
    else
      @hit =  0
    end
  end

  def show
    @book = RakutenWebService::Books::Book.search(isbn: params[:id])
    @reviews = Review.where(book_id: params[:id])
    @average = @reviews.average(:assess)
  end
end
