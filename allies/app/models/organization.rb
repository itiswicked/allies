class Organization < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :street_address, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
