require 'rails_helper'

RSpec.describe 'When a user visits a snack show page', type: :feature do
  scenario 'they see name, price, and locations that carry said snack' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    burger = dons.snacks.create!(name: "White Castle Burger", price: 3.50)
    snapple = dons.snacks.create!(name: "Peach Snapple", price: 2.50)
    marks  = owner.machines.create(location: "Mark's Mixed Drinks")
    sandwhich = marks.snacks.create!(name: "White Castle Burger", price: 3.50)
    snapple1 = marks.snacks.create!(name: "Peach Snapple", price: 2.50)
    drink = Snack.create!(name: "Peach Soda", price: 1.50)
    # SnackMachine.create!(snack_id: drink.id, machine_id: dons.id)
    SnackMachine.create!(snack_id: drink.id, machine_id: marks.id)
    dons.snacks << [drink, snapple1]
    marks.snacks << [snapple]

    visit "/snacks/#{drink.id}"
    # expect(page).not_to have_content("White Castle Burger")
    expect(page).to have_content("Peach Soda")
    expect(page).to have_content("$1.50")
    expect(page).to have_content("Don's Mixed Drinks")
    expect(page).to have_content("Mark's Mixed Drinks")

  end
  scenario 'average price for snacks in those vending machines' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    burger = dons.snacks.create!(name: "White Castle Burger", price: 3.50)
    snapple = dons.snacks.create!(name: "Peach Snapple", price: 2.50)
    marks  = owner.machines.create(location: "Mark's Mixed Drinks")
    sandwhich = marks.snacks.create!(name: "White Castle Burger", price: 3.50)
    snapple1 = marks.snacks.create!(name: "Peach Snapple", price: 2.50)
    drink = Snack.create!(name: "Peach Soda", price: 1.50)
    # SnackMachine.create!(snack_id: drink.id, machine_id: dons.id)
    SnackMachine.create!(snack_id: drink.id, machine_id: marks.id)
    dons.snacks << [drink, snapple1]
    marks.snacks << [snapple]
    visit "/snacks/#{drink.id}"
    expect(page).to have_content("Average Price: $2.50")

  end
  scenario 'count of the different kinds of items in that vending machine' do

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
