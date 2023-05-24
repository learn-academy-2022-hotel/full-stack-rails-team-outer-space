class AddColumnPasswordToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :password, :text
  end
end
