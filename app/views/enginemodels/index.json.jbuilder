json.array!(@enginemodels) do |enginemodel|
  json.extract! enginemodel, :modelcode, :name
  json.url enginemodel_url(enginemodel, format: :json)
end
