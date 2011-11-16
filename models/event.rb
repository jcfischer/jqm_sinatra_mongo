class Event
  include MongoMapper::Document

  key :name, String
  key :location, String
  key :url, String

end