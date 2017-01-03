class Label
  include MongoMapper::Document
  key :shipping_method, String
  key :url, String
  key :order_name, String
  key :tracking_number, String
  key :customer_name, String
  key :order_id, Integer
  timestamps!
end
