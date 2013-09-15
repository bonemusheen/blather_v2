require_relative "config/environment"
require "haml"
require "sinatra"

set :port, ENV["PORT"] || 4567

configure :production do
  require "rack/ssl"
  use Rack::SSL
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def logged_in?
    session["user_id"]
  end

  def user
    User.find session["user_id"]
  end

  def full_title(page_title)
    base_title = "Blather!"
    if page_title
      "#{base_title} | #{page_title}"
    else
      base_title
    end
  end
end

get "/" do
  haml :index
end

get "/signup" do
  haml :signup, locals: { title: "Sign Up" }
end