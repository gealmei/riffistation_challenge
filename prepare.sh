#! /bin/bash

knife solo prepare -i ~/Downloads/opsworks.pem -x ubuntu kibana_pub.challenge.aws.com --bootstrap-version 12.1.2
sleep 10
knife solo prepare -i ~/Downloads/opsworks.pem -x ubuntu logstash_pub.challenge.aws.com --bootstrap-version 12.1.2
sleep 10
knife solo prepare -i ~/Downloads/opsworks.pem -x ubuntu es1_pub.challenge.aws.com --bootstrap-version 12.1.2
sleep 10
knife solo prepare -i ~/Downloads/opsworks.pem -x ubuntu es2_pub.challenge.aws.com --bootstrap-version 12.1.2
sleep 10
knife solo prepare -i ~/Downloads/opsworks.pem -x ubuntu es3_pub.challenge.aws.com --bootstrap-version 12.1.2
