class Public::FavoritesController < ApplicationController
  def create
    review = Review.find(params[:review])
    favorite = current_user.favorites.new(review_id: review.id)
    favorite.save
    redirect_to public_book_path(params[:id])
  end

  def destroy
    review = Review.find(params[:review])
    favorite = current_user.favorites.find_by(review_id: review.id)
    favorite.destroy
    redirect_to public_book_path(params[:id])
  end
end
