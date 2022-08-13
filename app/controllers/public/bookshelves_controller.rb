class Public::BookshelvesController < ApplicationController
  def will_read_create
    book_shelves = Bookshelf.new
    book_shelves.will_read_id = params[:id]
    book_shelves.user_id = current_user.id
    book_shelves.book_title = params[:book_title]
    book_shelves.save
    redirect_to public_book_path(params[:id])
  end

  def read_create
    book_shelves = Bookshelf.find(params[:id])
    book_shelves.read_id = book_shelves.will_read_id
    book_shelves.will_read_id = nil
    book_shelves.save
    redirect_to public_user_path(current_user.id)
  end

  def destroy
    book_shelves = Bookshelf.find(params[:id])
    book_shelves.destroy
    redirect_to public_user_path(current_user.id)
  end



  private
  def book_shelf_params
     params.require(:bookshelf).permit(:read_id, :will_read_id, :book_title, :user_id)
  end

end
