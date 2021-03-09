require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations:' do

    it 'saves when all four required fields exist' do
      @category = Category.find_or_create_by name: 'Electronics'
      @product = @category.products.create({
        name: 'Iphone 10',
        quantity: 20,
        price: 900
      })
      expect(@product.id).to be_present
    end

    it "doesn't save when category is missing" do
      @product = Product.create({
        name: 'Printer XYZ',
        quantity: 10,
        price: 2000
      })
      expect(@product).to_not be_valid
      expect(@product.id).to be_nil
      expect(@product.errors.full_messages).to include("Category can't be blank")
      expect(@product.errors.full_messages.count).to eq 1
    end

    it "doesn't save when name is missing" do
      @category = Category.find_or_create_by name: 'Tennis Racquets'
      @product = @category.products.create({
        quantity: 40,
        price: 199
      })
      expect(@product).to_not be_valid
      expect(@product.id).to be_nil
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product.errors.full_messages.count).to eq 1
    end

    it "doesn't save when price is missing" do 
      @category = Category.find_or_create_by name: 'Books'
      @product = @category.products.create({
        name: 'Pride and Prejudice',
        quantity: 30
      })
      expect(@product).to_not be_valid
      expect(@product.id).to be_nil
      expect(@product.errors.full_messages).to include("Price can't be blank")
      expect(@product.errors.full_messages.count).to eq 3
    end

  end
end
