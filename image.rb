class Image
  include MongoMapper::Document
  key :src, String
  key :description, String
  key :position, Integer

  belongs_to :product
  timestamps!
end
