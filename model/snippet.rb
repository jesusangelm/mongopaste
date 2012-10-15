require "mongoid"

env = ENV['VCAP_SERVICES'] ? :production : :development
Mongoid.load!(File.expand_path("../mongoid.yml", __FILE__), env)

class Snippet
  include Mongoid::Document

  field :title, type: String
  field :language, type: String
  field :code, type: String

  validates_presence_of :title, :code, :language
end
