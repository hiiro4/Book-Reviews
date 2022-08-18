class Public::UsersController < ApplicationController

  def top
  end

  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id:@user.id)
    @book = RakutenWebService::Books::Book.search(isbn: params[:id])
    @books = Bookshelf.where(user_id:params[:id])
    @shelves_did = @books.where.not(read_id:nil)
    @shelves_will = @books.where.not(will_read_id:nil)
  end

  def follow
    follor = Relationship.where(be_followed_id:params[:id])
    @follow = User.where(user_id:follor.following_id)
  end

  def follower
    follor = Relationship.where(following_id:params[:id])
    @follow = User.where(user_id:follor.be_followed_id)
  end

end
