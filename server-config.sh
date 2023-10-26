sudo yum install git -y
sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install maven -y

if [ -d "addressbook" ]
then
  echo "repo is cloned and exists"
  cd /home/ec2-user/addressbook
  git pull origin b1
else
  git clone  https://github.com/anoop5843/addressbook.git
  cd addressbook
  git checkout b1
fi

mvn package
