class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @line_items = LineItem.where(order_id: @order.id)

    @products = @line_items.map { 
      |line_item| 
      { product: Product.find(line_item.product_id), quantity: line_item.quantity }
    }
  end
  
  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def price(old_price)
    if Sale.active.any?
      percent_off = Sale.active.all[0].percent_off
      new_price = old_price * ((100.00 - percent_off) / 100)
    else
      old_price
    end
  end

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    price = price(cart_subtotal_cents).floor
    puts cart_subtotal_cents
    puts price
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      price,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    price = price(cart_subtotal_cents)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: price,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      price = price(product.price)
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: price,
        total_price: price * quantity
      )
    end
    order.save!
    order
  end

end
