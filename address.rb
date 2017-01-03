class Address
  include MongoMapper::Document

  key :address1, String
  key :address2, String
  key :city, String
  key :company, String
  key :first_name, String
  key :last_name, String
  key :phone, String
  key :province, String
  key :country, String
  key :zip, String
  key :name, String
  key :province_code, String
  key :country_code, String
  key :country_name, String
  key :default, Boolean

  belongs_to :customer
  timestamps!
end
