class LineItem
  include MongoMapper::Document
  key :custom, Boolean
  key :title, String
  key :sku, String
  key :price, Float
  key :available, Boolean
  key :buy_price, Float
  key :shopify_variant_id, Integer
  key :shopify_product_id, Integer
  key :buy_price_usd, Float
  key :buy_price_aud, Float
  key :supplier_rrp, Float
  key :quantity, Integer, :default => 1

  belongs_to :quote
  timestamps!
end
