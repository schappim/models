class Setting
  include MongoMapper::Document
  key :sku, String

  timestamps!
end
