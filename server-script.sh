#! /bin/bash

sudo yum install git -y
sudo yum insatll java-1.8.0-openjdk-devel -y
sudo yum install maven -y


if [ -d "addressbook" ]
then
   echo "repo is cloned and exists"
   cd addressbook
   git pull origin devops-1/july
else
   git clone https://github.com/rajavelugithub/addressbook.git
   cd addressbook
fi

mvn test