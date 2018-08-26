#! /bin/sh
echo "running $0 $@"

# creation of goups and users is limited on demo servers
if [ -d /vagrant ]; then
  # Defaults
  install_git_project=true

  # Load the normalized project properties.
  source /tmp/$1.project.properties

  /usr/sbin/groupadd -r sshuser

  if [ $install_git_project == "true" ]; then
    # creation of goups and users is limited on demo servers
    /usr/sbin/groupadd -r sshuser
	/usr/sbin/groupadd -r vlad
    pass=$(perl -e 'print crypt($ARGV[0], "Majithia")' $1)
    /usr/sbin/useradd -m -G sshuser -p $pass $1
	/usr/sbin/usermod -a -G vlad  $1
  fi
fi
