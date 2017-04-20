package "openjdk-8-jdk" do
  action :install
  not_if "test -f /usr/java/default/bin/java"
end
