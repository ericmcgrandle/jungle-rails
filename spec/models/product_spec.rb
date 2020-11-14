require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # Create Category and Product
    let(:create_category) { Category.create(name: "RSpec Test") }
    let(:create_product) { Product.new({ name: "Rspec", description: "Test", price_cents: 10000, quantity: 10, category_id: create_category.id }) }
    
    it "saves successfully" do
      expect do
        create_category.save
      end.to change{ Category.count }.by(1)
      expect do
        create_product.save
      end.to change{ Product.count }.by(1)

    end
  end
end