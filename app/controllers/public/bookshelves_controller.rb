class Public::BookshelvesController < ApplicationController
  def will_read_create
    book_shelves = Bookshelf.new
    book_shelves.will_read_id = params[:id]
    book_shelves.user_id = current_user.id
    book_shelves.book_title = params[:book_title]
    book_shelves.save
    redirect_to public_book_path(params[:id])
  end

  def show
    @boo = Bookshelf.where(user_id:params[:id])
  end

  private
  def book_shelf_params
     params.require(:bookshelf).permit(:read_id, :will_read_id, :book_title, :user_id)
  end

end
