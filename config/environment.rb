require "bundler/setup"
require "active_record"
require_relative "../lib/user"
require_relative "../lib/message"

if ENV["RACK_ENV"] == "test"
  ActiveRecord::Base.establish_connection "sqlite3:///db/test_database.sqlite3"
else
  ActiveRecord::Base.establish_connection ENV["DATABASE_URL"] || "sqlite3:///db/database.sqlite3"
end