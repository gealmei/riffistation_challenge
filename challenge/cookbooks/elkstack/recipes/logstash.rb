include_recipe 'elkstack::jdk8'

bash 'setup_logstash_repo' do
  code <<-EOH
    echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
    sudo apt-get update
    EOH
  not_if "[ -f /etc/logstash/logstash.json ]"
end

package 'logstash' do
    action :install
    options "--allow-unauthenticated"
end

service 'logstash' do
    supports status: true, restart: true, reload: true
    action [ :enable, :start ]
end

execute 'logstash-plugin' do
    command '/usr/share/logstash/bin/logstash-plugin install logstash-codec-avro && /usr/share/logstash/bin/logstash-plugin install logstash-filter-alter && /usr/share/logstash/bin/logstash-plugin install logstash-filter-ruby && /usr/share/logstash/bin/logstash-plugin install logstash-input-tcp && /usr/share/logstash/bin/logstash-plugin install logstash-input-udp && touch /root/logstash-plugins.done'
    not_if 'test -e /root/logstash-plugins.done'
    action :run
end

template 'etc/logstash/conf.d/logstash-syslog.conf' do
    owner 'root'
    group 'root'
    mode 0644
    source 'etc/logstash/conf.d/logstash-syslog.conf.erb'
    notifies :restart, 'service[logstash]', :delayed
end

cookbook_file "etc/logstash/logstash.json" do
    owner "root"
    group "root"
    mode 0644
    source "etc/logstash/logstash.json"
    notifies :restart, "service[logstash]", :delayed
end
