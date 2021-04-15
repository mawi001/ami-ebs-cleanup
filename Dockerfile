FROM ubuntu:20.04

RUN apt-get update && apt-get install -y ansible python3-pip

RUN ansible-galaxy collection install community.aws && \
ansible-galaxy collection install amazon.aws

RUN pip3 install boto boto3

WORKDIR /app

COPY . /app

ENV PATH=/usr/bin:/bin:$PATH
