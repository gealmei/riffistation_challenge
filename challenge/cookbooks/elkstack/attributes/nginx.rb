default['nginx']['package'] = "nginx"
default[:nginx][:enable_pci] = false

default['nginx']['worker_process'] = 1
default['nginx']['worker_connections'] = 1024
default['nginx']['keepalive_timeout'] = 65
default['nginx']['input_file_name'] = "/var/log/nginx/error.log"
default['nginx']['input_file_tag'] = "nginx"
default['nginx']['input_file_state_file'] = "stat-nginx-error"
default['nginx']['input_file_severity'] = "error"
# 0-Emergency, 1-Alert, 2-Critical, 3-Error, 4-Warning, 5-Notice, 6-Informational, 7-Debug
default['nginx']['input_file_facility'] = "local3"
default['nginx']['input_file_poll_interval'] = "10"
default['nginx']['preserve_fqdn'] = "on"
# we send messages by UDP protocol. If you _need_ TCP, change from: '@' to '@@'
default['nginx']['syslog_server'] = "@radio.vmcommerce.intra:6061"
default[:nginx][:custom] = false
default['nginx']['worker_rlimit_nofile'] = nil
