require 'rails_helper'

describe 'amusement park show page' do

  before do
    @amusement_park = AmusementPark.create!(name: "Siz Flags Over Texas", admission_cost: 40)
    @mechanic1 = Mechanic.create!(name: 'Charles', years_experience: 2)
    @mechanic2 = Mechanic.create!(name: 'Mary', years_experience: 4)
    @ride1 = Ride.create!(name: 'Texas Titan', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
    @ride2 = Ride.create!(name: 'Mr. Freeze', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
    RideMechanic.create!(mechanic_id: @mechanic1.id, ride_id: @ride1.id)
    RideMechanic.create!(mechanic_id: @mechanic1.id, ride_id: @ride2.id)
    RideMechanic.create!(mechanic_id: @mechanic2.id, ride_id: @ride2.id)
    visit amusement_park_path(@amusement_park)
  end
  describe 'amusement park details' do
    it 'has its name' do
      expect(page).to have_content("Name: #{@amusement_park.name}")
    end
    it 'has its admission cost' do
      expect(page).to have_content("Admission Cost: #{@amusement_park.admission_cost}")
    end
    describe 'mechanics list' do
      it 'has a list of mechanics' do
        expect(page).to have_content(@mechanic1.name)
        expect(page).to have_content(@mechanic2.name)
      end

      it 'that list is of unique mechanics' do
        expect(page).to have_content(@mechanic1.name, count: 1)
      end
    end
    describe 'rides list' do
      before do
        @mechanic3 = Mechanic.create!(name: 'Sally', years_experience: 3)
        RideMechanic.create!(mechanic_id: @mechanic3.id, ride_id: @ride2.id)
        visit amusement_park_path(@amusement_park)
      end
      it 'has a list of ride names' do
        expect(page).to have_content('Rides:')
        expect(page).to have_content("Ride name: #{@ride1.name}")
        expect(page).to have_content("Ride name: #{@ride2.name}")
      end

      it 'has a list of ride mechanic experience' do
        expect(page).to have_content("Ride name: #{@ride1.name} ... Average Mechanic Experience: 2")
        expect(page).to have_content("Ride name: #{@ride2.name} ... Average Mechanic Experience: 3")
      end
    end
  end
end