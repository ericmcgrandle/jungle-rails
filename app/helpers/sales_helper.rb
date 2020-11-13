module SalesHelper
  def active_sale?
    Sale.active.all
  end
end