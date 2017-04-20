knife solo cook -i ~/Downloads/opsworks.pem -x ubuntu -r "recipe[riffstation::elasticseach]" es1_pub.challenge.aws.com
sleep 20
knife solo cook -i ~/Downloads/opsworks.pem -x ubuntu -r "recipe[riffstation::elasticseach]" es2_pub.challenge.aws.com
sleep 20
knife solo cook -i ~/Downloads/opsworks.pem -x ubuntu -r "recipe[riffstation::elasticseach]" es3_pub.challenge.aws.com
sleep 20
knife solo cook -i ~/Downloads/opsworks.pem -x ubuntu -r "recipe[riffstation::logstash]" logstash_pub.challenge.aws.com
sleep 20
knife solo cook -i ~/Downloads/opsworks.pem -x ubuntu -r "recipe[riffstation::kibana]" kibana_pub.challenge.aws.com
