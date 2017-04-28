class Page
  include MongoMapper::Document

  key :title, String
  key :post_body, String
  key :post_snippet, String
  key :handle, String
  key :published, Boolean
  key :date, Date
  key :img, String

end
