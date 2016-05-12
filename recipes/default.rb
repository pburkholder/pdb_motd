file node['motd']['path'] do
  content node['motd']['message']
  owner 'root'
  group 'root'
  mode '0666'
end
