json.array!(@products) do |product|
  json.extract! product, :id, :category_id, :title, :description, :qnt, :price, :image_url
  json.url product_url(product, format: :json)
end
