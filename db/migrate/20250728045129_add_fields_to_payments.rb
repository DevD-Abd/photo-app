class AddFieldsToPayments < ActiveRecord::Migration[8.0]
  def change
    add_column :payments, :stripe_customer_id, :string
    add_column :payments, :stripe_charge_id, :string
    add_column :payments, :plan, :string
    add_column :payments, :amount, :integer
  end
end
