class BackInStockRequest
  include MongoMapper::Document
  key :email, String
  key :product_id, Integer
  key :notified, Boolean
  
  timestamps!
end
