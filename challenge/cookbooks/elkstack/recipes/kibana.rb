include_recipe 'elkstack::jdk8'
include_recipe 'elkstack::nginx'
include_recipe 'elkstack::elasticsearch'

bash 'setup_kibana_repo' do
  code <<-EOH
    echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
    sudo apt-get update
    EOH
  not_if "[ -f /etc/kibana/kibana/kibana.yml ]"
end

package "kibana" do
  action :install
  options "--allow-unauthenticated"
  not_if "test -f /usr/java/default/bin/java"
end

package "rsyslog" do
  action :install
end
service "rsyslog" do
   supports status: true, restart: true, reload: true
   action [ :enable, :start ]
end

service "kibana" do
   supports status: true, restart: true, reload: true
   action [ :enable, :start ]
end

template '/etc/elasticsearch/elasticsearch.yml' do
    owner 'root'
    group 'root'
    mode 0644
    source 'etc/elasticsearch/elasticsearch.yml.erb'
    notifies :restart, 'service[elasticsearch]', :delayed
end

template '/etc/kibana/kibana.yml' do
    owner 'root'
    group 'root'
    mode 0644
    source 'opt/kibana/config/kibana.yml.erb'
    notifies :restart, 'service[kibana]', :delayed
end

template '/etc/nginx/conf.d/nginx.conf' do
    owner 'root'
    group 'root'
    mode 0644
    source 'etc/nginx/conf.d/nginx.conf.erb'
    notifies :restart, 'service[nginx]', :delayed
end

cookbook_file '/etc/rsyslog.d/nginx.conf' do
    source 'etc/rsyslog.d/nginx.conf'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[rsyslog]', :delayed
end
