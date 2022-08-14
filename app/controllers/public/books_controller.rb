class Public::BooksController < ApplicationController

  def index
    @bookshelves = Bookshelf.where(user_id:current_user.id)
    #本の検索
    if params[:keyword].present? #入力されているか
      if params[:book_category] == "title" #検索方法の選択
        @books = RakutenWebService::Books::Book.search(title: params[:keyword])
        @hit = @books.count
      elsif params[:book_category] == "author"
        @books = RakutenWebService::Books::Book.search(author: params[:keyword])
        @hit = @books.count
      end
    else
      @hit = 0
    end
    #レビューの検索
    if params[:review_range] == "all"
      @reviews = Review.all #全てのレビューから検索
      @hoge = 1
      if  params[:review_type] == "favorite"
        @reviews = Review.includes(:favorite_users).sort {|a,b| b.favorite_users.size <=> a.favorite_users.size}
      elsif params[:review_type] == "new"
        @reviews = Review.all.order(created_at: :desc)
      end
    elsif params[:review_range] == "my"
      @hoge = 1
      @reviews = Review.where(user_id:current_user.id)    #自身のレビューから検索
      if  params[:review_type] == "favorite"
        @reviews = @reviews.includes(:favorite_users).sort {|a,b| b.favorite_users.size <=> a.favorite_users.size}
      elsif params[:review_type] == "new"
        @reviews = Review.all.order(created_at: :desc)
      end
    else
       @reviews = Review.all.order(created_at: :desc)
       @hoge = 0
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
