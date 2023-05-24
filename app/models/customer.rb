class Customer < ApplicationRecord
  # The method on the custom validator is called by including ActiveModel::Validations and using the validates_with method
  include ActiveModel::Validations
  validates_with CustomValidation

  belongs_to :service_plan

  # add uniqueness helper with scope option on foreign key
  validates :name, :account, presence: true, uniqueness: { scope: :service_plan_id }

  # multiple scopes - multiple attributes are placed in an array
  #  validates :name, :account, presence: true, uniqueness: { scope: [:name, :account] }

  # validates :name, :account, presence: true

  # validates_uniqueness_of with scope, ensure presence validation helper available separately
  # validates_uniqueness_of :name, :account, scope: :service_plan_id 

  # multiple attributes
  # validates_uniqueness_of :name, :account

  validates :name, length: { minimum: 2} 

  # numericality
  # validates :account, numericality: true
  validates :account, numericality: { message: 'Please input numbers only' }
end

# each test will need to be modified to include password