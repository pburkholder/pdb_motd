require 'inspec'

describe file('/etc/motd') do
  its(:content) { should match(/Property of DevOpsDC/) }
end
