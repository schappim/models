class Product
  include MongoMapper::Document
  key :title, String


  key :hstariff, String


  key :description, String
  key :specs, String

  
  key :collections, Array
  key :cat_primary_handle, String
  key :cat_secondary_handle, String

  key :cat_primary_title, String
  key :cat_secondary_title, String

  key :supplier_cats, Array


  key :sku, String, :unique => true
  key :lbe_sku, String
  key :mpn, String # Supplier SKU
  key :notes, String # Notes Field
  key :alternates, Array # Alternate Products

  key :shopify_variant_id, Integer
  key :shopify_product_id, Integer
  key :shopify_handle, String

  key :supplier_product_url, String

  key :supplier_inv, Integer, :default => 0
  key :local_inv, Integer, :default => 0
  key :ebay_inv, Integer, :default => 0
  key :weight, Integer, :default => 100
  
  key :reorder_inv, Integer, :default => 0
  key :do_not_order, Boolean, :default => false

  key :buy_price_usd, Float
  key :buy_price_aud, Float
  key :supplier_rrp, Float
  key :reseller_price, Float # The price we sell to Kogan
  key :price, Float # AUD
  key :retired, Boolean
  key :featured, Boolean

  key :moq, Integer

  key :published, Boolean

  def handle
    return self.shopify_handle
  end

  def supplier_inv_calculated

    available = supplier_inv

    if local_inv < 1
      available = supplier_inv + local_inv
    end

    if available < 0
      available = 0
    end

    return available

  end
  

  belongs_to :supplier
  many :inventories
  many :images
  many :resources
  timestamps!

  
end

class Resource
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :canonical_url, String
end
