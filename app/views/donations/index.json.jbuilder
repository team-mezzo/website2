json.array!(@donations) do |donation|
  json.extract! donation, :id, :pickup_start, :pickup_end, :status
  json.url donation_url(donation, format: :json)
end
