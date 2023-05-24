require 'rails_helper'

RSpec.describe ServicePlan, type: :model do
  # testing for an entry missing plan attribute
  it 'is not valid without a plan' do
    basic = ServicePlan.create(price: 175)
    p "basic entry", basic
      # Output: "basic entry"
      #<ServicePlan id: nil, plan: nil, price: 175, created_at: nil, updated_at: nil>
      p "errors", basic.errors.full_messages
        # output: "errors"
        # ["Plan can't be blank"]
    expect(basic.errors[:plan]).to_not be_empty
  end

  # testing for an entry missing price attribute
  it 'is not valid without a price' do
    basic = ServicePlan.create(plan: 'Basic')
    expect(basic.errors[:price]).to_not be_empty
  end

end
