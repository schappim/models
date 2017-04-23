class School
  include MongoMapper::Document

  key :name, String
  key :company, String # Some schools have a corporate name


  # Google
  key :formatted_address, String
  key :place_id, String
  
  # Is the school open or closed?
  key :status, String

  # Shipping ETA
  key :regular_post_min, Integer
  key :regular_post_max, Integer
  key :express_post_min, Integer
  key :express_post_max, Integer


  # School Address
  key :address1, String
  key :address2, String
  key :city, String
  key :province, String
  key :zip, String
  key :country, String
  key :phone, String
  key :fax, String
  key :website, String 

  key :shipping_notes, String # E.g. Only deliver between XYZ.
  key :shipping_method, String # Default Shipping Method


  # Account Department
  key :vendor_id, String # The Vendor ID they give to LBE

  key :accounts_first_name, String
  key :accounts_last_name, String

  key :accounts_email, String
  key :accounts_phone, String
  key :accounts_fax, String


  # Demographic Information
  key :category, String # Gov, Catholic, Anglican, Advetist, Islamic
  key :students, String # M/F/Co-ed
  key :years, String # K-12 / P-12 / 7-12

  key :tags, Array # E-Textiles, Robotics, Arduino, Raspberry Pi etc.

  
  many :customers

end
