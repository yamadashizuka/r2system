json.array!(@repairs) do |repair|
  json.extract! repair, :issueNo, :issueDate, :arriveDate, :startDate, :finishDate, :beforeComment, :afterComment
  json.url repair_url(repair, format: :json)
end
