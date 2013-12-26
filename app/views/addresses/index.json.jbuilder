json.array!(@addresses) do |address|
  json.extract! address, :id, :name, :street, :street2, :apartment_number, :city, :state, :zip
  json.url address_url(address, format: :json)
end
