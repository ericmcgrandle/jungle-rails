# Jungle

A mockup of an ecommerce site. This project was created to learn Ruby, Ruby on Rails and various testing libraries including Rspec and Capybara. This project intentionally utilizes an older version of Rails to simulate a real world situation of working on an older codebase. 


# Stack

Ruby, Ruby On Rails, ActiveRecord, Rspec, Capybara and Poltergeist


## Setup for local machine

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server


## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>


## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe


## Final Project

!["Screenshot of Full View"](https://github.com/ericmcgrandle/jungle-rails/blob/master/docs/Products.png?raw=true)
!["Screenshot of Full View"](https://github.com/ericmcgrandle/jungle-rails/blob/master/docs/Cart.png?raw=true)
!["Screenshot of Full View"](https://github.com/ericmcgrandle/jungle-rails/blob/master/docs/Order.png?raw=true)
!["Screenshot of Full View"](https://github.com/ericmcgrandle/jungle-rails/blob/master/docs/Stripe.png?raw=true)
!["Screenshot of Full View"](https://github.com/ericmcgrandle/jungle-rails/blob/master/docs/admin-all-products.png?raw=true)
