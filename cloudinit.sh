#!/bin/bash
sudo amazon-linux-extras install docker -y

sudo service docker start
sudo systemctl enable docker

sudo usermod -a -G docker ec2-user

sudo pip3 install docker-compose

sudo wget https://raw.githubusercontent.com/angelocho/hello-amazon/main/compose.yaml

sudo chown ec2-user compose.yaml
