json.array!(@toppings) do |topping|
  json.extract! topping, :id, :name, :description, :cost, :topping_list_id
  json.url topping_url(topping, format: :json)
end
