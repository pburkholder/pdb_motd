# Encoding: utf-8

require 'rspec/core/rake_task'

task default: [:cop, :foodcritic, :spec]
task all: [:default, :kitchen]
task validate: :default



desc '1 Run RuboCop'
task :cop do
  sh('rubocop')
end

desc '2 Run Foodcritic'
task :foodcritic do
  sh('foodcritic', '-f', 'any', '.')
end

desc '3 Run ChefSpec unit tests'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--format documentation'
end

desc '4 Run KitchenCI'
task :kitchen do
  sh('kitchen', 'converge', 'centos-6')
  sh('kitchen', 'verify', 'centos-6')
end
