require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'is not valid without a name attribute' do
    basic = ServicePlan.create(plan: 'Basic', price: 175)
    aubrey = basic.customers.create(account: 183312345, paid: true, password: 'bas1c')
    nicole = basic.customers.create(account: 183312346, paid: true, password: 'bas1c')
    # p "basic entry", basic
    # p "aubrey entry", aubrey
    # p "entries that belong to basic", basic.customers
    # p aubrey.errors.full_messages
    expect(aubrey.errors[:name]).to_not be_empty
  end

  it 'is not valid without an account attribute' do
    premium = ServicePlan.create(plan: 'Premium', price: 200)
    scott = premium.customers.create(name: 'Scott', paid: false, password: 'prem1um')
    expect(scott.errors[:account]).to_not be_empty
  end

  it 'is not valid if the name is less than 2 characters' do
    premium = ServicePlan.create(plan: 'Premium', price: 200)
    premium.customers.create(name: 'H', account: 183312346, paid: false, password: 'prem1um')
    premium.customers.create(name: 'W', account: 183312346, paid: false, password: 'prem1um')
    # p 'premium.customers', premium.customers
    # p 'errors', premium.customers[0].errors.full_messages
    expect(premium.customers[0].errors[:name]).to_not be_empty
  end

  # reflect_on_association
  it 'belongs to a service plan' do
    trish = Customer.reflect_on_association(:service_plan)
    expect(trish.macro).to eq(:belongs_to)
  end

  # custom validator
  it 'is not valid with a password created without a number' do
    luxury = ServicePlan.create(plan: 'Luxury', price: 400)
    chacha = luxury.customers.create(name: 'ChaCha', account: 183312349, paid: true, password: 'luxury')
    # p chacha.errors.full_messages
    expect(chacha.errors[:password]).to_not be_empty
  end

  # no duplications
  it 'is not valid with duplicate customers on a service plan' do
    luxury = ServicePlan.create(plan: 'Luxury', price: 400)
    luxury.customers.create(name: 'ChaCha', account: 183312349, paid: true, password: '1uxury')
    luxury.customers.create(name: 'ChaCha', account: 183312349, paid: true, password: '1uxury')
    # p luxury.customers[1].errors.full_messages
    expect(luxury.customers[1].errors[:name]).to_not be_empty
    expect(luxury.customers[1].errors[:account]).to_not be_empty
  end

  # numericality
  it 'only allows integers in the account' do
    luxury = ServicePlan.create(plan: 'Luxury', price: 400)
    luxury.customers.create(name: 'ChaCha', account: 'l833l2349', paid: true, password: '1uxury')
    p luxury.customers[0].errors[:account]
    expect(luxury.customers[0].errors[:account]).to_not be_empty
    # custom error message for numericality
    expect(luxury.customers[0].errors[:account]).to eq(['Please input numbers only'])
  end


end
