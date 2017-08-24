#! /bin/sh
echo "running $0 $@"

set -e

# Convert all property keys to lowercase and store to tmp file to be sourced.
if [ -f /vagrant/project.properties ]; then
  sed 's/.*=/\L&/' /vagrant/project.properties > /tmp/$4.project.properties
elif [ -f project.properties ]; then
  sed 's/.*=/\L&/' project.properties > /tmp/$4.project.properties
elif [ -f /opt/vagrant/project.properties ]; then
  sed 's/.*=/\L&/' /opt/vagrant/project.properties > /tmp/$4.project.properties
else
  printf "ml_version=$2\n" > /tmp/$4.project.properties
fi

# Run the installers.
sudo /opt/vagrant/restore-yum-cache.sh
sudo /opt/vagrant/update-os.sh $4
sudo /opt/vagrant/install-ml-centos.sh $4
sudo /opt/vagrant/setup-ml-master.sh $1 $2 $3
sudo /opt/vagrant/install-node.sh $4
sudo /opt/vagrant/install-mlcp.sh $4
sudo /opt/vagrant/install-user.sh $4
sudo /opt/vagrant/setup-git.sh $4
sudo /opt/vagrant/setup-pm2.sh $4
sudo /opt/vagrant/setup-httpd.sh $4
sudo /opt/vagrant/setup-tomcat.sh $4
sudo /opt/vagrant/backup-yum-cache.sh
