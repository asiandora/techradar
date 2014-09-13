# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

require 'quality/rake/task'
Quality::Rake::Task.new do |t|
  t.skip_tools = %w(cane flog flay)
end

# BROKEN fails with Devise secret key error
desc "Run RSpec with code coverage"
task :spec_with_coverage do
  ENV["COVERAGE"] = "true"
  Rake::Task["spec"].execute
end

task default: [:spec, :quality]
