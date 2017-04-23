class Customer
  include MongoMapper::Document
  key :email, String
  key :first_name, String
  key :last_name, String
  key :shopify_customer_id, String
  key :last_order_id, String
  key :last_order_name, String
  key :orders_count, Integer
  key :note, String
  key :state, String
  key :tags, String
  key :tax_exempt, Boolean
  key :total_spent, Float
  key :verified_email, Boolean
  key :accepts_marketing, Boolean
  key :education, Boolean



  many :addresses
  timestamps!
end
