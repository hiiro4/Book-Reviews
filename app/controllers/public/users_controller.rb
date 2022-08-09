class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id:@user.id)
    @book = RakutenWebService::Books::Book.search(isbn: params[:id])
    @books = Bookshelf.where(user_id:params[:id])
  end
end
