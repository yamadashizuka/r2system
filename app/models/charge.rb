class Charge < ActiveRecord::Base
  belongs_to :repair
  belongs_to :engine

  belongs_to :branch, :class_name => 'Company' 

end
