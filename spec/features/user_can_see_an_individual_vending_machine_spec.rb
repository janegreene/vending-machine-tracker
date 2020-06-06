require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario 'they see name and price of snacks' do
     owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    burger = dons.snacks.create!(name: "White Castle Burger", price: 3.50)
    drink = dons.snacks.create!(name: "Peach Soda", price: 1.50)
    visit machine_path(dons)
    # save_and_open_page
    expect(page).to have_content("White Castle Burger")
    expect(page).to have_content("Peach Soda")
    expect(page).to have_content("$3.50")
    expect(page).to have_content("$1.50")
  end
  scenario 'see average price for all of the snacks in that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    burger = dons.snacks.create!(name: "White Castle Burger", price: 3.50)
    drink = dons.snacks.create!(name: "Peach Soda", price: 1.50)
    snapple = dons.snacks.create!(name: "Peach Snapple", price: 2.50)
    visit machine_path(dons)
    expect(page).to have_content("Average Price: $2.50")
  end
end
# User Story 3 of 3
#
# As a visitor
# When I visit a snack show page
# I see the name of that snack
#   and I see the price for that snack
#   and I see a list of locations with vending machines that carry that snack
#   and I see the average price for snacks in those vending machines
#   and I see a count of the different kinds of items in that vending machine.

# As a visitor
# When I visit a vending machine show page
# I also see an average price for all of the snacks in that machine

# As a visitor
# When I visit a vending machine show page
# I see the name of all of the snacks associated with that vending machine along with their price
# rails g migration CreateSnacks name:string price:float
# rails g migration CreateSnackMachines snack:references machine:references
