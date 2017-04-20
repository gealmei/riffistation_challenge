package "nginx" do
        action :install
        not_if "[ -f /usr/sbin/nginx ]"
end

template "/etc/nginx/nginx.conf" do
  owner "root"
  group "root"
  mode 0644
  source "etc/nginx/nginx.conf.erb"
  notifies :restart, "service[nginx]", :delayed
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
