class EventLead
  include MongoMapper::Document
  key :name, String
  key :school, String
  key :email, String, :unique => true
  key :contacted, Boolean
  key :notes, String
  timestamps!
end
