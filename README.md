## AWS EC2 AMI cleanup

Delete AMIs in AWS account that are older then certain age and not in-use to launch active EC2 instances.

## Usage:

Run cleanup with defaults in region `us-east-1`

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
