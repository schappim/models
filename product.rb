class Product
  include MongoMapper::Document
  key :title, String

  key :description, String
  key :specs, String

  key :cat_primary_handle, String
  key :cat_secondary_handle, String

  key :cat_primary_title, String
  key :cat_secondary_title, String

  key :supplier_cats, Array


  key :sku, String, :unique => true
  key :lbe_sku, String
  key :shopify_variant_id, Integer
  key :shopify_product_id, Integer
  key :shopify_handle, String

  key :supplier_product_url, String

  key :supplier_inv, Integer, :default => 0
  key :local_inv, Integer, :default => 0
  key :ebay_inv, Integer, :default => 0
  
  key :reorder_inv, Integer, :default => 0
  key :do_not_order, Boolean, :default => false

  key :buy_price_usd, Float
  key :buy_price_aud, Float
  key :supplier_rrp, Float
  key :price, Float # AUD

  key :moq, Integer

  

  belongs_to :supplier
  many :images
  many :resources
  timestamps!
end

class Resource
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :canonical_url, String
end
