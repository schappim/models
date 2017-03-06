

class Supplier
  include MongoMapper::Document
  key :name, String
  key :sku_prefix, String
  key :country, String
  key :lead_time, Integer
  key :login, String
  key :password, String
  key :url, String
  key :logo, String
  key :handle, String

  many :products
  many :supplier_categories
  many :supplier_order
  many :sync_logs

  timestamps!
end

class SupplierOrder
  include MongoMapper::Document
  
  key :po_number, Integer 
  key :tracking_number, String 
  
  key :ordered, Boolean, :default => false

  many :supplier_order_line_items
  belongs_to :supplier

  timestamps!
end

class SupplierOrderLineItem
  include MongoMapper::Document

  key :sku, String
  key :supplier_sku, String
  key :qty, Integer
  key :ordered_for, Array

  timestamps!
end