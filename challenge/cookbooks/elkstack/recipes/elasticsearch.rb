include_recipe "elkstack::jdk8"

bash 'install_elsticsearch' do
  code <<-EOH
    sudo apt-get install openjdk-8-jre
    curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.3.0.deb
    sudo dpkg -i elasticsearch-5.3.0.deb
    EOH
  not_if "[ -f /etc/elasticsearch/elasticsearch.yml ]"
end

node.set['elasticsearch']['cluster_name'] = 'elkstack'

if node.name.include?('es1') or node.name.include?('kibana')
    node.set['elasticsearch']['node_master'] = true
    node.set['elasticsearch']['node_data'] = false
else
    node.set['elasticsearch']['node_master'] = false
    node.set['elasticsearch']['node_data'] = true
end

template "/etc/elasticsearch/elasticsearch.yml" do
  owner "root"
  group "root"
  mode 0644
  source "etc/elasticsearch/elasticsearch.yml.erb"
  notifies :restart, "service[elasticsearch]", :delayed
end

service "elasticsearch" do
  service_name "elasticsearch"
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end


