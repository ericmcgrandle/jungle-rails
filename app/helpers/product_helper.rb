module ProductHelper
  def sold_out?(product)
    product.quantity == 0
  end

  def getUser(id)
    User.find(id)
  end
end