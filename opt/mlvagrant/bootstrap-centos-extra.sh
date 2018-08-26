#! /bin/sh
echo "running $0 $@"

# Convert all property keys to lowercase and store to tmp file to be sourced.
if [ -f /vagrant/project.properties ]; then
  sed 's/.*=/\L&/' /vagrant/project.properties > /tmp/$4.project.properties
elif [ -f project.properties ]; then
  sed 's/.*=/\L&/' project.properties > /tmp/$4.project.properties
elif [ -f /opt/mlvagrant/project.properties ]; then
  sed 's/.*=/\L&/' /opt/mlvagrant/project.properties > /tmp/$4.project.properties
else
  printf "ml_version=$2\n" > /tmp/$4.project.properties
fi

# Run the installers.
sudo /opt/mlvagrant/restore-yum-cache.sh
sudo /opt/mlvagrant/update-os.sh $4
sudo /opt/mlvagrant/install-ml-centos.sh $4
sudo /opt/mlvagrant/setup-ml-extra.sh $@
sudo /opt/mlvagrant/backup-yum-cache.sh
