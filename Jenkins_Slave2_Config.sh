#! /bin/bash
sudo yum install java-17-amazon-corretto-devel -y
sudo yum install git -y
sudo yum install maven -y

if [ -d "addressbook" ]
then
  echo "repo is cloned and repo exists"
  cd /home/ec2-user/addressbook
  git checkout master
  git pull origin master
else
 git clone https://github.com/preethid/addressbook.git
 cd /home/ec2-user/addressbook
 git checkout master
fi
cd addressbook
mvn package