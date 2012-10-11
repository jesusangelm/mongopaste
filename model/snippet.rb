require "mongoid"

if ENV["VCAP_SERVICES"]
  Mongoid.load!(File.expand_path("../mongoid.yml", __FILE__), :production)
else
  Mongoid.load!(File.expand_path("../mongoid.yml", __FILE__), :development)
end

class Snippet
  include Mongoid::Document

  field :title, type: String
  field :language, type: String
  field :code, type: String
end
