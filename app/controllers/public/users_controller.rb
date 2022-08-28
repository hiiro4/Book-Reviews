class Public::UsersController < ApplicationController
   before_action :specified_user, only: [:index, :destroy]

  def index
    users = User.where.not(check:2)
    @users = users.where.not(check:3)
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
    follor = Relationship.where(be_followed_id:params[:id]).pluck(:following_id)
    @follow = User.where(id:follor)
  end

  def follower
    follor = Relationship.where(following_id:params[:id]).pluck(:be_followed_id)
    @follow = User.where(id:follor)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to  public_users_path
  end

  private

  def specified_user
    redirect_to public_books_path unless current_user.check == "2"
  end
end
