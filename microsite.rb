class Microsite

  include MongoMapper::Document

  key :handle, String
  key :title, String
  key :keywords, String
  key :rotator, String
  key :description, String
  key :lead, String
  key :author, String
  key :domain, String
  key :name, String
  key :facebook_url, String
  key :twitter_url, String
  key :phone, String
  key :street_address, String
  key :email, String
  key :url, String
  key :copyright, String

  many :msite_collections

  timestamps!

end

class MsiteCollection

  include MongoMapper::EmbeddedDocument

  key :title, String
  key :handle, String
  key :products, Array

end