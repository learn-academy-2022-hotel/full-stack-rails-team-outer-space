class ServicePlan < ApplicationRecord
  validates :plan, :price, presence: true
  has_many :customers
end
