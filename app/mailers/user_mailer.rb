class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"
  layout 'mailer'

  def welcome_email(order)
    @order = order
    line_items = LineItem.where(order_id: order.id)
    @products = line_items.map { |line_item| { product: Product.find(line_item.product_id), quantity: line_item.quantity } }

    mail(to: @order[:email], subject: "Thank you for your order! Order ID : #{@order[:id]}")
  end
end
