class ChirpyUser
  include MongoMapper::Document
  
  key :first_name, String
  key :last_name, String
  key :email, String
  key :image, String
  key :uid, String
  key :default_a4_printer, String
  key :default_large_dymo, String
  key :default_small_dymo, String

  def name
    return "#{self.first_name} #{self.last_name}"
  end

  def short_name
    return "#{self.first_name} #{self.last_name[0,1]}."
  end

  timestamps!
end