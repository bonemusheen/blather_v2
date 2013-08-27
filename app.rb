require_relative "config/environment"
require "sinatra"

set :port, ENV["PORT"] || 4567

configure :production do
  require "rack/ssl"
  use Rack::SSL
end

get "/" do
  "Hello world"
end