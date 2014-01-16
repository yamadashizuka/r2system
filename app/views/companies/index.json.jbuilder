json.array!(@companies) do |company|
  json.extract! company, :name, :category
  json.url company_url(company, format: :json)
end
