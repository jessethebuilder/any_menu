json.array!(@items) do |item|
  json.extract! item, :id, :name, :description, :tax_exempt, :dont_deliver, :topping_list_id
  json.url item_url(item, format: :json)
end
