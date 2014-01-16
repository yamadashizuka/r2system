json.array!(@enginestatuses) do |enginestatus|
  json.extract! enginestatus, :name
  json.url enginestatus_url(enginestatus, format: :json)
end
