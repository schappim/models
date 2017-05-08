class SiteRedirect
  include MongoMapper::Document

  key :old_path, String
  key :target_path, String

end