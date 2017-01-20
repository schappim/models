class Category
  include MongoMapper::Document
  key :title, String
  key :shopify_id, Integer
  key :handle, String
  key :children, Array
  key :parent, ObjectId
  
  timestamps!
end

# Collection for Chirpy
class Collection
  include MongoMapper::Document
  key :title, String
  key :handle, String
  key :description, String
  many :sub_collections
  timestamps!
end

class SubCollection
  include MongoMapper::Document
  key :title, String
  key :handle, String
  key :description, String
  belongs_to :sub_collections
  timestamps!
end