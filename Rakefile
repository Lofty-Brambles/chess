# rubocop:disable Naming/FileName
# rubocop:enable Naming/FileName

# frozen_string_literal: true

require 'rubocop/rake_task'

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb']
  task.formatters = ['files']
  task.fail_on_error = false
end

desc 'Run the program'
task :run do
  ruby 'lib/main.rb'
end

desc 'Run all test suites'
task :test do
  rspec
end
