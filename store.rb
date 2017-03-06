class Store
  include MongoMapper::Document
  many :leads
  many :marketing_img

  timestamps!
end

class Lead
  include MongoMapper::EmbeddedDocument
  key :url, String
  key :content, String
end

class MarketingImg
  include MongoMapper::EmbeddedDocument
  key :x1, String
  key :x2, String
  key :url, String
end