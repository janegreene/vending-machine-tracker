require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end
  describe 'relationships' do
    it { should have_many :snack_machines  }
    it {should have_many(:snacks).through(:snack_machines)}
  end
  describe 'methods' do

   it '#average_price' do
     owner = Owner.create(name: "Sam's Snacks")
     dons  = owner.machines.create(location: "Don's Mixed Drinks")
     burger = dons.snacks.create!(name: "White Castle Burger", price: 3.50)
     drink = dons.snacks.create!(name: "Peach Soda", price: 1.50)
     snapple = dons.snacks.create!(name: "Peach Snapple", price: 2.50)
     expect(dons.average_price).to eq(2.50)
   end
   it '#snack_types' do
     owner = Owner.create(name: "Sam's Snacks")
     dons  = owner.machines.create(location: "Don's Mixed Drinks")
     burger = dons.snacks.create!(name: "White Castle Burger", price: 3.50)
     drink = dons.snacks.create!(name: "Peach Soda", price: 1.50)
     snapple = dons.snacks.create!(name: "Peach Snapple", price: 2.50)
     expect(dons.snack_types).to eq(3)
   end
  end
end
