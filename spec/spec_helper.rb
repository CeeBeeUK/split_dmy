if ENV['CODECLIMATE_REPO_TOKEN']
  # allow Code Climate Test coverage reports to be sent
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end
