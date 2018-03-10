#!/bin/bash

if [ $# -eq 0 ]
  then
    uc_hostname=$1
else
  uc_hostname=ucsrv.lab
fi

sudo useradd stack
sudo passwd stack  # specify a password
echo "stack ALL=(root) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/stack
sudo chmod 0440 /etc/sudoers.d/stack
sudo su - stack
sudo hostnamectl set-hostname $uc_hostname
sudo hostnamectl set-hostname --transient $uc_hostname

#   127.0.0.1   myhost.mydomain myhost
#sudo yum install -y https://trunk.rdoproject.org/centos7/current-tripleo/python2-tripleo-repos-0.0.1-0.20171116021457.15e17a8.el7.centos.noarch.rpm
sudo -u stack /bin/bash <<\DEVOPS_BLOCK
# Become stack user here
`source /home/stack/.bash_profile`
id
whoami
cd ~
pwd
sudo yum install -y https://trunk.rdoproject.org/centos7/current/python2-tripleo-repos-0.0.1-0.20180306114928.3fb8f7b.el7.centos.noarch.rpm
sudo -E tripleo-repos -b newton current
sudo -E tripleo-repos -b newton current ceph
sudo yum install -y python-tripleoclient
sudo yum install -y ceph-ansible
sudo cp /vagrant/configs/undercloud.conf  ~/undercloud.conf
sudo chown stack:stack ~/undercloud.conf
sudo -u stack openstack undercloud install
# Back to the root user here
DEVOPS_BLOCK
