class SupplierDelivery
  include MongoMapper::Document
  key :order_number, String
  key :supplier, String
  key :tracking, String
  key :courier, String
  key :status, String
  key :eta, String

  many :delivery_checkpoints
  timestamps!
end

class DeliveryCheckpoint
  include MongoMapper::EmbeddedDocument
 
 	key :slug, String, :default => ""
    key :city, String, :default => ""
    key :created_at, String, :default => ""
    key :country_name, String, :default => ""
    key :message, String, :default => ""
    key :country_iso3, String, :default => ""
    key :tag, String, :default => ""
    key :checkpoint_time, String, :default => ""
    key :coordinates, Array, :default => []
    key :state, String, :default => ""
    key :zip, String, :default => ""

  	timestamps!
end
