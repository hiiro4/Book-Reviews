class Public::BooksController < ApplicationController

  def index
    #ジャンル一覧取得books_genre_id
    #roots = RakutenWebService::Books::Genre.root
    #byebug
    #roots.children.each do |child|
    #byebug
     #@put = child.booksGenreName
    #byebug
    #end
    #byebug
    #本の検索
    @bookshelves = Bookshelf.where(user_id:current_user.id)
    if params[:keyword].present? #入力されているか
      if params[:book_category] == "title" #検索方法の選択
        books = RakutenWebService::Books::Book.search(title: params[:keyword])
        @hit = books.count
        @page = Kaminari.paginate_array([books], total_count: @hit).page(params[:page]).per(10)#kaminariページネーション
        if params[:page].nil?
          now_page = 1
        else
          now_page = params[:page]
        end
        @books = RakutenWebService::Books::Book.search(title: params[:keyword],page: now_page,hits: 10)#楽天からのページ毎に取得
      elsif params[:book_category] == "author"
        books = RakutenWebService::Books::Book.search(author: params[:keyword])
        @hit = books.count
        @page = Kaminari.paginate_array([books], total_count: @hit).page(params[:page]).per(10)
        if params[:page].nil?
          now_page = 1
        else
          now_page = params[:page]
        end
        @books = RakutenWebService::Books::Book.search(title: params[:keyword],page: now_page,hits: 10)
      end
    else
      @hit = 0
    end
    #レビューの検索
    if params[:review_range] == "all"
      @reviews = Review.all #全てのレビューから検索
      @hoge = 1
      @page = Kaminari.paginate_array([@reviews], total_count: @reviews.count).page(params[:page]).per(10)#kaminariページネーション
        if  params[:review_type] == "favorite"
          @reviews = Review.includes(:favorite_users).page(params[:page]).per(10).sort {|a,b| b.favorite_users.size <=> a.favorite_users.size}
        elsif params[:review_type] == "new"
          @reviews = Review.all.order(created_at: :desc).page(params[:page]).per(10)
        end
    elsif params[:review_range] == "my"
      @hoge = 1
      @reviews = Review.where(user_id:current_user.id)#自身のレビューから検索
      @page = Kaminari.paginate_array([@reviews], total_count: @reviews.count).page(params[:page]).per(10)#kaminariページネーション
        if  params[:review_type] == "favorite"
          @reviews = @reviews.includes(:favorite_users).page(params[:page]).per(10).sort {|a,b| b.favorite_users.size <=> a.favorite_users.size}
        elsif params[:review_type] == "new"
          @reviews = Review.all.order(created_at: :desc).page(params[:page]).per(10)
        end
    elsif params[:review_range] == "follow"
      @hoge = 1
      if Relationship.where(be_followed_id:current_user.id).present?#フォロワーを取得、存在を判定
         follower = Relationship.where(be_followed_id:current_user.id).pluck(:following_id)
         #byebug
         @reviews = Review.where(user_id:follower)#フォロワーのレビューを取得
         @page = Kaminari.paginate_array([@reviews], total_count: @reviews.count).page(params[:page]).per(10)#kaminariページネーション
          if  params[:review_type] == "favorite"
            @reviews = @reviews.includes(:favorite_users).page(params[:page]).per(10).sort {|a,b| b.favorite_users.size <=> a.favorite_users.size}
          elsif params[:review_type] == "new"
            @reviews = @reviews.all.order(created_at: :desc).page(params[:page]).per(10)
          end
      else
        @hoge = 0
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
