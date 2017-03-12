class Quote
  include MongoMapper::Document
  key :number, Integer
  key :customer_name, String
  key :customer_company, String
  key :notes, String

  many :line_items


  timestamps!
end
