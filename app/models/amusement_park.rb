class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :ride_mechanics, through: :rides 
  has_many :mechanics, through: :ride_mechanics
  validates_presence_of :name
  validates_presence_of :admission_cost
  validates_numericality_of :admission_cost
  
  def unique_mechanics_names
    mechanics.distinct.pluck(:name)
  end

  
end