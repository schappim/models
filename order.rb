class Order
  include MongoMapper::Document
  key :name, String
  key :shopify_id, Integer
  key :po_number, String
  key :fulfillment_status, String
  key :tracking, String
  key :token, String
  key :email, String
  key :customer_last_updated, Time

  many :order_line_items

  timestamps!
end


class OrderLineItem
  include MongoMapper::EmbeddedDocument
  
  key :shopify_line_item_id, Integer
  key :shopify_variant_id, Integer
  key :shopify_product_id, Integer
  
  key :local_inv_at_time_of_order, Integer
  key :supplier_inv_at_time_of_order, Integer
  key :backordered, Boolean

  key :title, String
  key :name, String
  key :sku, String
  key :ordering_note, String

  key :variant_title, String
  key :vendor, String
  
  key :supplier_order_number, String
 
  key :quantity, Integer
  key :fulfillable_quantity, Integer

  key :price, Float
  key :grams, Integer
 
  key :requires_shipping, Boolean
  key :gift_card, Boolean
  
  timestamps!
end
