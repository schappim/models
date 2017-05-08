class SupplierOrder
  include MongoMapper::Document
  
  #key :po_number, Integer 
  key :tracking_number, String 
  
  key :ordered, Boolean, :default => false

  many :supplier_order_line_items
  belongs_to :supplier

  timestamps!
end


#
#class SupplierOrderLineItem
#  include MongoMapper::Document
#
#  key :sku, String
#  key :supplier_sku, String
#  key :qty, Integer
#  key :ordered_for, Array
#
#  timestamps!
#end