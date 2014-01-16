class Company < ActiveRecord::Base
	has_many :engineorders

#法人のCSVをインポートする
def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
    Company.create! row.to_hash
  end
end

end
