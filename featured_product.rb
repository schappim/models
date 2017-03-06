class FeaturedProduct
  include MongoMapper::Document

  many :products
  timestamps!
end