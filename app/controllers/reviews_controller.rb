class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    product_id = params[:product_id]
    description = params[:products][:description]
    rating = params[:products][:rating]
    
    @review = Review.new(product_id: product_id, description: description, rating: rating)

    if current_user
      @review.user_id = current_user[:id]
    end
    
    if @review.save
      redirect_to "/products/#{product_id}", notice: 'Product created!'
    else
      redirect_to "/products/#{product_id}", notice: 'Product NOT created!'    
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to "/products/#{params[:product_id]}", notice: "Deleted"
  end
end
