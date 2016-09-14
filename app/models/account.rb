class Account < ApplicationRecord
  belongs_to :customer

  has_many :devices, through: :customer
end
