file node['motd']['path'] do
  content node['motd']['content']
  owner 'root'
  group 'root'
  mode '0666'
end
