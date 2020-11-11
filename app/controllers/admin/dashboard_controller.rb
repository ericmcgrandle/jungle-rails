class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]

  def show
    @msg = "here"

    @categories = Category.count
    @categories_name = Category.all()
    @products = Product.all()


  end
end
