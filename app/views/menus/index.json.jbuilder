json.array!(@menus) do |menu|
  json.extract! menu, :id, :name, :description, :store_id
  json.url menu_url(menu, format: :json)
end
