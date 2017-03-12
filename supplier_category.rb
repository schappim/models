class SupplierCategory
  include MongoMapper::Document
  key :title, String
  key :supplier_cat_id, String
  key :lb_id, String
  
  belongs_to :supplier
  timestamps!
end
