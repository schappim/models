class Hierarchy
  include MongoMapper::Document
  key :json, String
  key :html, String
  timestamps!
end
