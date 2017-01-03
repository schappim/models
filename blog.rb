class Blog
  include MongoMapper::Document

  key :url, String
  
  timestamps!
end
