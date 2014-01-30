class ChangeCompanyIdTypeToUser < ActiveRecord::Migration  
  def self.up
    change_column :users, :company_id, :integer
  end

  def self.down
    change_column :users, :company_id, :string
  end
end
