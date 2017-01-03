class Category
  include MongoMapper::Document
  key :title, String
  key :shopify_id, Integer
  key :handle, String
  key :children, Array
  key :parent, ObjectId
  
  timestamps!
end