class RemoveChargePriceToCharges < ActiveRecord::Migration
  def change
    remove_column :charges, :charge_price, :integer
  end
end
