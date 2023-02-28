class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :ride_mechanics
  has_many :mechanics, through: :ride_mechanics
  validates_presence_of :name
  validates_presence_of :thrill_rating
  validates_numericality_of :thrill_rating

  validates_presence_of :open


  def average_mech_exp 
    mechanics.average(:years_experience)
  end
end