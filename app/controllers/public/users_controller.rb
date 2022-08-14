class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id:@user.id)
    @book = RakutenWebService::Books::Book.search(isbn: params[:id])
    @books = Bookshelf.where(user_id:params[:id])
    @shelves_did = @books.where.not(read_id:nil)
    @shelves_will = @books.where.not(will_read_id:nil)
  end
end
