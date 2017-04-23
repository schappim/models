class FeaturedProduct
  include MongoMapper::Document

  key :product_id, Object

  many :products, :in => :product_id
  timestamps!
end