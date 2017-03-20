class Location
  include MongoMapper::Document

  key :type, String # Local/Supplier
  key :qty, Integer # Local/Supplier

  belongs_to :inventory
  timestamps!
end