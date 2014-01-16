json.array!(@engineorders) do |engineorder|
  json.extract! engineorder, :issueNo, :inquiryDate, :loginUserId, :branchCode, :userId, :placeCode, :orderer, :machineNo, :timeOfRunning, :changeComment, :orderDate, :sendingCompanyCode, :sendingComment, :deliveryDate
  json.url engineorder_url(engineorder, format: :json)
end
