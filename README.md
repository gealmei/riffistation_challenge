# riffistation_challenge
Interview Challenge for Riffistation

This project it consists in deploy a ELKStack at AWS enviromment provisioning all necessary resources.

follow thes steps to deploy works

1. Ajust the file riffistation_challenge/default.tfvars input all data necessary to work in your enviromment

2. choose wich terraform plan to run between riffistation_challenge/elkstack_chef to use chef server or riffistation_challenge/elkstack to use chef solo
	2.1 in case of use riffistation_challenge/elkstack_chef rename it to riffistation_challenge/elkstack_chef.tf, move riffistation_challenge/elkstack.tf to riffistation_challenge/elkstack_chef.tf_option and execute #terraform apply -var-file=default.tfvars
	2.2 in case of use riffistation_challenge/elkstack execute #terraform apply -var-file=default.tfvars
3. If your choice was "2.1" all plan will deply infrastrcture and applications, if your choice was 2.2 follow the next steps
	3.1 change the files names at folder "riffistation_challenge/challenge/nodes", for example #mv es1_pub.challenge.aws.com.json es1_pub.<private domain chosed in private_dns var>.json
	3.1 edit file prepare.sh, for example "sed -i.bak s/challenge.aws.com/<private domain chosed in private_dns var>/g prepare.sh
	3.2 edit file cook.sh, for example "sed -i.bak s/challenge.aws.com/<private domain chosed in private_dns var>/g cook.sh
	3.3 after your instances are running at aws execute ./riffistation_challenge/prepare.sh
	3.4 when prepare finish execut ./riffistation_challenge/cook.sh
4. After all kibana ar accessible to in http://kibana_pub.<public domain chosed in public_dns var>/ and Logstash is receiving Kibana's Nginx access log

Improovments TO DO
 In case to use chef solo, will be better to automate some steps like check if AWS instances are running after apply the plan and execute the prepare and cook steps
