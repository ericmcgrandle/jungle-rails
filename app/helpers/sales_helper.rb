module SalesHelper
  def active_sale?
    Sale.active.all
  end
  def new_price(old_price)
    percent_off = active_sale?[0].percent_off
    new_price = old_price * ((100.00 - percent_off) / 100)
  end
end