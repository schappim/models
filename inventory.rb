class Inventory
  include MongoMapper::Document

  key :type, String # Local/Supplier
  key :qty, Integer # Local/Supplier

  belongs_to :product
  one :location

  timestamps!
end