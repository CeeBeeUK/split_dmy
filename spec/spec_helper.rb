if ENV['CODECLIMATE_REPO_TOKEN']
  # allow Code Climate Test coverage reports to be sent
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load File.dirname(__FILE__) + '/support/schema.rb'
require File.dirname(__FILE__) + '/support/models.rb'
