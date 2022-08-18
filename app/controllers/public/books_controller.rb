class Public::BooksController < ApplicationController

  def index
    #ジャンル一覧取得
    #roots = RakutenWebService::Books::Genre.root (bookapiだがbook以外も取得)
    #byebug
    #roots.children.each do |child|
    #byebug
    # @put = child.booksGenreName   取得不能(名称は合っている)
    #end
    #byebug
    #本の検索
    @bookshelves = Bookshelf.where(user_id:current_user.id)
    if params[:keyword].present? #入力されているか
      if params[:book_category] == "title" #検索方法の選択
        books = RakutenWebService::Books::Book.search(title: params[:keyword])
        @hit = books.count
        @page = Kaminari.paginate_array([books], total_count: @hit).page(params[:page]).per(10)
        if params[:page].nil?
          now_page = 1
        else
          now_page = params[:page]
        end
        @books = RakutenWebService::Books::Book.search(title: params[:keyword],page: now_page,hits: 10)
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
      @page = @reviews.page(params[:page])
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
    elsif params[:review_range] == "follow"
      @hoge = 1
      if Relationship.where(be_followed_id:current_user.id).present?#フォロワーを取得、存在を判定
         follower = Relationship.where(be_followed_id:current_user.id).pluck(:following_id)
         #byebug
         @reviews = Review.where(user_id:follower)#フォロワーのレビューを取得
        if  params[:review_type] == "favorite"
          @reviews = @reviews.includes(:favorite_users).sort {|a,b| b.favorite_users.size <=> a.favorite_users.size}
        elsif params[:review_type] == "new"
          @reviews = Review.all.order(created_at: :desc)
        end
      else
        @judge = フォロワーがいません
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
