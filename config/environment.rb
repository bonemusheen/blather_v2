require "bundler/setup"
require "active_record"
require "bcrypt"
require_relative "../lib/user"
require_relative "../lib/message"

ActiveRecord::Base.establish_connection ENV["DATABASE_URL"] || "sqlite3:///db/database.sqlite"
configure :test do
  ActiveRecord::Base.establish_connection "sqlite3:///db/test_database.sqlite"
end