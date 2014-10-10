class AddBranchidToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :branch_id, :integer
  end
end
