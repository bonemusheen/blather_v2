task :environment do
  require_relative "config/environment"
end

namespace :db do
  task migrate: :environment do
    ActiveRecord::Migrator.migrate 'db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil
  end
end