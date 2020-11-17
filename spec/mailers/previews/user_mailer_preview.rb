# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    order = Order.new(id: 1, total_cents: 305200, created_at: "2020-11-16 21:55:56", updated_at: "2020-11-16 21:55:56", stripe_charge_id: "ch_1HoFfzFYSOtlZUHeQz1BGtT8", email: "kvirani@gmail.com")
    send_email = UserMailer.welcome_email(order).deliver_now
  end
end