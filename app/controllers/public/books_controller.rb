class Public::BooksController < ApplicationController

  def index
    @bookshelves = Bookshelf.where(user_id:current_user.id)
    if params[:keyword].present? #入力されているか
      if params[:search] == "title" #検索方法の選択
        @books = RakutenWebService::Books::Book.search(title: params[:keyword])
        @hit = @books.count
      elsif params[:search] == "author"
        @books = RakutenWebService::Books::Book.search(author: params[:keyword])
        @hit = @books.count
      end
    else
      @hit = 0
    end
  end

  def show
    @book = RakutenWebService::Books::Book.search(isbn: params[:id])
    @reviews = Review.where(book_id: params[:id])
    @review = Review.where(user_id:current_user.id)
    @average = @reviews.average(:assess)
    @bookshelves = Bookshelf.where(user_id:current_user.id)
  end
end
