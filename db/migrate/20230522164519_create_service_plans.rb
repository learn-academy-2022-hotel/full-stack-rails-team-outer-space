class CreateServicePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :service_plans do |t|
      t.string :plan
      t.integer :price

      t.timestamps
    end
  end
end
