class SyncLog
  include MongoMapper::Document
  key :status, String

  belongs_to :supplier

  timestamps!
end
