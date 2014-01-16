json.array!(@businessstatuses) do |businessstatus|
  json.extract! businessstatus, :name
  json.url businessstatus_url(businessstatus, format: :json)
end
