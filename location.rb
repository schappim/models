class Location
  include MongoMapper::Document

  key :warehouse, String
  key :zone, String
  key :rack, String 
  key :shelf, String
  key :slot, String

  belongs_to :inventory
  timestamps!
end