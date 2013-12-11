json.array!(@topping_lists) do |topping_list|
  json.extract! topping_list, :id, :name, :description
  json.url topping_list_url(topping_list, format: :json)
end
