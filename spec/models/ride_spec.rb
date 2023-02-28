require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'relationships' do
    it { should belong_to(:amusement_park) }
    it { should have_many(:ride_mechanics) }
    it { should have_many(:mechanics).through(:ride_mechanics) }
    it { should validate_presence_of :name}
    it { should validate_presence_of :thrill_rating}
    it { should validate_presence_of :open}
    it { should validate_numericality_of :thrill_rating}
  end

  describe '#average_mech_exp' do
    before do
      @amusement_park = AmusementPark.create!(name: "Siz Flags Over Texas", admission_cost: 40)
      @mechanic1 = Mechanic.create!(name: 'Charles', years_experience: 4)
      @mechanic2 = Mechanic.create!(name: 'Mary', years_experience: 10)
      @ride1 = Ride.create!(name: 'Texas Titan', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
      RideMechanic.create!(mechanic_id: @mechanic1.id, ride_id: @ride1.id)
      RideMechanic.create!(mechanic_id: @mechanic2.id, ride_id: @ride1.id)
    end
    it 'should return the average mechanic experience' do
      expect(@ride1.average_mech_exp).to eq(7)
    end
  end
end

