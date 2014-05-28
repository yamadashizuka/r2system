class AddCompanyToRepair < ActiveRecord::Migration
  def change
    add_reference :repairs, :company, index: true
  end
end
