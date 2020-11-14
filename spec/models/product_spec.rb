require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Initial Test' do
    # Create Category and Product
    let(:create_category) { Category.create(name: "RSpec Test") }
    let(:create_product) { Product.create({ name: "Rspec", description: "Test", price_cents: 10000, quantity: 10, category_id: create_category.id }) }
    
    it "saves successfully" do
      expect do
        create_category.save
      end.to change{ Category.count }.by(1)
      expect do
        create_product.save
      end.to change{ Product.count }.by(1)

    end
  end

    describe 'Validates' do
      let(:create_category) { Category.create(name: "RSpec Test") }

      # NAME
      it "name nil" do
        product_create = Product.create({ name: nil, description: "Test", price_cents: 10000, quantity: 10, category_id: create_category.id })

        expect(product_create.errors.full_messages).to include("Name can't be blank")
      end

      it "name something" do
        expect do
          Product.create({ name: "RSpec", description: "Test", price_cents: 10000, quantity: 10, category_id: create_category.id })
        end.to change{ Product.count }.by(1)
      end

      # PRICE
      it "price nil" do
        product_create = Product.create({ name: "Test", description: "Test", price_cents: nil, quantity: 10, category_id: create_category.id })

        expect(product_create.errors.full_messages).to include("Price cents is not a number")
        expect(product_create.errors.full_messages).to include("Price can't be blank")
        expect(product_create.errors.full_messages).to include("Price is not a number")
      end

      it "price not a number" do
        product_create = Product.create({ name: "Test", description: "Test", price_cents: 'abc', quantity: 10, category_id: create_category.id })

        expect(product_create.errors.full_messages).to include("Price cents is not a number")
      end

      it "price something" do
        expect do
          Product.create({ name: "RSpec", description: "Test", price_cents: 10000, quantity: 10, category_id: create_category.id })
        end.to change{ Product.count }.by(1)
      end

      # Quantity
      it "quantity nil" do
        product_create = Product.create({ name: "Test", description: "Test", price_cents: 100000, quantity: nil, category_id: create_category.id })

        expect(product_create.errors.full_messages).to include("Quantity can't be blank")
      end

      it "quantity not a number" do
        product_create = Product.create({ name: "Test", description: "Test", price_cents: 100000, quantity: 'abc', category_id: create_category.id })

        expect(product_create.errors.full_messages).to include()
      end

      it "quantity something" do
        expect do
          Product.create({ name: "RSpec", description: "Test", price_cents: 10000, quantity: 10, category_id: create_category.id })
        end.to change{ Product.count }.by(1)
      end

      # Category
      it "category nil" do
        product_create = Product.create({ name: "Test", description: "Test", price_cents: 100000, quantity: 10000, category_id: nil })

        expect(product_create.errors.full_messages).to include("Category can't be blank")
      end

      it "category something" do
        expect do
          Product.create({ name: "RSpec", description: "Test", price_cents: 10000, quantity: 10, category_id: create_category.id })
        end.to change{ Product.count }.by(1)
      end

    end
end