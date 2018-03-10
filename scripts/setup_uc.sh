#!/bin/bash

# setting hostname
if [ $# -eq 0 ]
  then
    uc_hostname=$1
else
  uc_hostname=ucsrv.lab
fi

# creating default stack user
# sudo useradd stack
# echo -e "pass123wd\npass123wd" | sudo passwd stack
# echo "stack ALL=(root) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/stack
# sudo chmod 0440 /etc/sudoers.d/stack

sudo hostnamectl set-hostname $uc_hostname
sudo hostnamectl set-hostname --transient $uc_hostname

sudo yum install -y https://trunk.rdoproject.org/centos7/current/python2-tripleo-repos-0.0.1-0.20180306114928.3fb8f7b.el7.centos.noarch.rpm
sudo -E tripleo-repos -b newton current
sudo -E tripleo-repos -b newton current ceph
sudo yum install -y python-tripleoclient
sudo yum install -y ceph-ansible
sudo cp /vagrant/configs/undercloud.conf  ~/undercloud.conf
sudo chown stack:stack ~/undercloud.conf
openstack undercloud install
# Back to the root user here
#DEVOPS_BLOCK
