# Encoding: utf-8

require 'rspec/core/rake_task'

task default: [:cop, :foodcritic, :spec]
task all: [:default, :kitchen]
task validate: :default

desc 'Run ChefSpec unit tests'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--format documentation'
end

desc 'Run RuboCop'
task :cop do
  sh('rubocop')
end

desc 'Run Foodcritic'
task :foodcritic do
  sh('foodcritic', '-f', 'any', '.')
end

desc 'Run KitchenCI'
task :kitchen do
  sh('kitchen', 'converge', 'centos-6')
  sh('kitchen', 'verify', 'centos-6')
end
