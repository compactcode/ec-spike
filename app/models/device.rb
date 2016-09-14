class Device < ApplicationRecord
  belongs_to :customer

  has_many :accounts, through: :customer
end
