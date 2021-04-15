#!/usr/bin/env bash

docker build -t ami-ebs-cleanup:local .

# run cleanup in us-east-1
docker run -it --rm -v ~/.aws:/root/.aws -e AWS_REGION=us-east-1 ami-ebs-cleanup:local ansible-playbook -v ami-cleanup.yml
docker run -it --rm -v ~/.aws:/root/.aws -e AWS_REGION=us-east-1 ami-ebs-cleanup:local ansible-playbook -v ebs-cleanup.yml

# run cleanup in us-east-2
docker run -it --rm -v ~/.aws:/root/.aws -e AWS_REGION=us-east-2 ami-ebs-cleanup:local ansible-playbook -v ami-cleanup.yml
docker run -it --rm -v ~/.aws:/root/.aws -e AWS_REGION=us-east-2 ami-ebs-cleanup:local ansible-playbook -v ebs-cleanup.yml

# run cleanup in us-west-1
docker run -it --rm -v ~/.aws:/root/.aws -e AWS_REGION=us-west-1 ami-ebs-cleanup:local ansible-playbook -v ami-cleanup.yml
docker run -it --rm -v ~/.aws:/root/.aws -e AWS_REGION=us-west-1 ami-ebs-cleanup:local ansible-playbook -v ebs-cleanup.yml
