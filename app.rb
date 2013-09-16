ENV["RACK_ENV"] = "test"

require_relative "config/environment"
require_relative "config/secure_token"
require "haml"
require "sass"
require "sinatra"
require "rack-flash"
require "sinatra/redirect_with_flash"

set :port, ENV["PORT"] || 4567

configure :production do
  require "rack/ssl"
  use Rack::SSL
end

use Rack::Session::Cookie, secret: secure_token
use Rack::Flash, sweep: true

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

  def gravatar_for(user, options = { size: 50 } )
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    "%img{ src: gravatar_url, alt: user.name, class: 'gravatar' }"
  end
end

get "/style.css" do
  scss :style, views: "#{settings.root}/public/css"
end

get "/" do
  haml :index
end

get "/signup" do
  haml :signup, locals: { title: "Sign Up" }
end

post "/signup" do
  user = User.new(name: params["name"],
                  email: params["email"],
                  password: params["password"],
                  password_confirmation: params["password_confirmation"])
  if user.save
    flash[:success] = "Welcome to Blather!"
    session[:user_id] = user.id
    redirect "/"
  else
    flash[:error] = user.errors
    redirect "/signup"
  end
end

get "/signout" do
  session.clear
  redirect "/"
end