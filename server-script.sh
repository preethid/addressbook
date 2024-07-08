#! /bin/bash

sudo yum install git -y
# sudo yum insatll java-1.8.0-openjdk-devel -y
# sudo yum install maven -y
sudo yum install docker -y
sudo systemctl start docker


if [ -d "addressbook" ]
then
   echo "repo is cloned and exists"
   cd addressbook
   git pull origin feature/cicd-docker
else
   git clone https://github.com/preethid/addressbook.git
     cd addressbook
      git checkout feature/cicd-docker
fi

docker build -t $1 .