# Riffistation Challenge
Interview Challenge for Riffistation

This project it consists in deploy a ELKStack at AWS enviromment provisioning all necessary resources.

follow thes steps to deploy works

1. Ajust the file riffistation_challenge/default.tfvars input all data necessary to work in your enviromment

2. choose wich terraform plan to run between riffistation_challenge/elkstack_chef to use chef server or riffistation_challenge/elkstack to use chef solo
    2.1 in case of use riffistation_challenge/elkstack_chef rename it to riffistation_challenge/elkstack_chef.tf, move riffistation_challenge/elkstack.tf to riffistation_challenge/elkstack_chef.tf_option, upload the cookbook to your chef-server and execute #terraform apply -var-file=default.tfvars
    2.2 in case of use riffistation_challenge/elkstack execute #terraform apply -var-file=default.tfvars
3. If your choice was "2.1" all plan will deply infrastrcture and applications, if your choice was 2.2 follow the next steps
    3.3 after your instances are running at aws execute ./riffistation_challenge/prepare.sh
    3.4 when prepare finish execut ./riffistation_challenge/cook.sh
4. After all kibana ar accessible to in http://kibana_pub.challenge.aws.com/ and Logstash is receiving Kibana's Nginx access log

Improovments TO DO
 In case to use chef solo, will be better to automate some steps like check if AWS instances are running after apply the plan and execute the prepare and cook steps
