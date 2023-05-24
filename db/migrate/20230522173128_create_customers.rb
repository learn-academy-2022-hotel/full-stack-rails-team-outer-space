class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :account
      t.boolean :paid
      t.integer :service_plan_id

      t.timestamps
    end
  end
end
