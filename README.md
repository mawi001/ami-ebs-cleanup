## AWS EC2 AMI cleanup

Delete AMIs in AWS account that are older then certain age and not in-use to launch active EC2 instances.


## Prerequisites

The playbook requires the `~/.aws` configdir to be present on the host that will run the playbook.
This dir contains your AWS credentials and profile config.

## Usage:

### All-in-one (AIO) script

See `run.sh`

This script will build the docker image with all dependencies and run the cleanup of AMIs and EBS snapshot on the following regions:

```sh
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
```


### Run playbooks manually or with default overrides

Run cleanup with defaults (AMIs older then 30 days) in region `us-east-1`

```sh
AWS_REGION=us-east-1 ansible-playbook -v ami-cleanup.yml
```

Override default `ami_filter_age` from cli:

Delete AMIs older then 1 day and not in use.

```sh
AWS_REGION=us-east-1 ansible-playbook -v ami-cleanup.yml -e ami_filter_age="'1 day'"
```


## AWS EBS snapshot cleanup

Delete EBS snapshots in AWS account that are older then certain age and not in-use by volume or AMI.


## Usage:

Run cleanup with defaults (snapshots older then 30 days) in region `us-east-1`

```sh
AWS_REGION=us-east-1 ansible-playbook -v ebs-cleanup.yml
```

Delete EBS snapshots older then 1 day and not in use.

```sh
AWS_REGION=us-east-1 ansible-playbook -v ebs-cleanup.yml -e snapshot_filter_age="'1 day'"
```


## Development

Build the docker image

```sh
docker build -t ami-ebs-cleanup:local .
```

Run the docker container

```sh
docker run -it ami-ebs-cleanup:local bash

root@e40604345951:/app# ls
Dockerfile  README.md  ami-cleanup.yml  ebs-cleanup.yml  list-amis.yml


```
