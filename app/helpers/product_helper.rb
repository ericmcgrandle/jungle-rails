module ProductHelper
  def sold_out?(product)
    product.quantity == 0
  end
end