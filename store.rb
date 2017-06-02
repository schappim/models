class Store
  include MongoMapper::Document
  many :leads
  many :marketing_img

  many :discountcodes

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
  key :alt, String
end


class Discountcode
  include MongoMapper::EmbeddedDocument
  key :discount_code, String
  key :dollar_value, Float
  key :percent_value, Float
  key :expire_date, String
end


