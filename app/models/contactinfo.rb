class Contactinfo < ActiveRecord::Base
  default_scope { order(:id) }
end
