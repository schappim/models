class Pickup
  include MongoMapper::Document
  key :name, String
  key :signature, String
  key :carrier, String
  key :day, String
  key :trackings, Array
 
  timestamps!
end

