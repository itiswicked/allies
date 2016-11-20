class User < ApplicationRecord
  belongs_to :organization
  has_many :organizations, through: :volunteers

  accepts_nested_attributes_for :organization 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
