Vagrant.configure("2") do |config|
   # oc-cmpt-srv
   config.vm.define "cmptpln" do |cmptpln|
    cmptpln.vm.box = "centos7"
    cmptpln.vm.hostname = 'cmptpln.lab'
    cmptpln.vm.box_url = "file:///Users/ongomr/DevOps/tech/vagrant/boxes/centos7.box"
    #oc-cmpt-pln.vm.network :private_network, ip: "192.168.56.12"
    cmptpln.vm.network :private_network, ip: "172.168.0.12",
    virtualbox__intnet: "vlan_os_int"
    cmptpln.vm.network :forwarded_port, guest: 22, host: 10124, id: "ssh"
    cmptpln.vm.provider :virtualbox do |vcmptpln|
      vcmptpln.customize ["modifyvm", :id, "--hwvirtex", "on"]
      vcmptpln.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vcmptpln.customize ["modifyvm", :id, "--memory", 4096]
      vcmptpln.customize ["modifyvm", :id, "--cpus", 2]
      vcmptpln.customize ["modifyvm", :id, "--name", "cmptpln"]
    end
     config.vm.synced_folder "./configs/", "/mnt/configs"
     config.vm.provision "shell", path: "scripts/setup_ssh.sh"
     config.vm.provision "shell", path: "scripts/setup_locale.sh"
     config.vm.provision "shell", inline: "sudo yum update -y"
     config.vm.provision "shell", path: "scripts/setup_oc_cmpt_pln.sh"
   end

   # oc-cntl-srv
   config.vm.define "cntlpln" do |cntlpln|
    cntlpln.vm.box = "centos7"
    cntlpln.vm.hostname = 'cntlpln.lab'
    cntlpln.vm.box_url = "file:///Users/ongomr/DevOps/tech/vagrant/boxes/centos7.box"
    #oc-cntl-pln.vm.network :private_network, ip: "192.168.56.11"
    cntlpln.vm.network :private_network, ip: "172.168.0.11",
    virtualbox__intnet: "vlan_os_int"
    cntlpln.vm.network :forwarded_port, guest: 22, host: 10123, id: "ssh"
    cntlpln.vm.provider :virtualbox do |vcntlpln|
      vcntlpln.customize ["modifyvm", :id, "--hwvirtex", "on"]
      vcntlpln.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vcntlpln.customize ["modifyvm", :id, "--memory", 2048]
      vcntlpln.customize ["modifyvm", :id, "--cpus", 2]
      vcntlpln.customize ["modifyvm", :id, "--name", "cntlpln"]
    end
     config.vm.synced_folder "./configs/", "/mnt/configs"
     config.vm.provision "shell", path: "scripts/setup_ssh.sh"
     config.vm.provision "shell", path: "scripts/setup_locale.sh"
     config.vm.provision "shell", inline: "sudo yum update -y"
     config.vm.provision "shell", path: "scripts/setup_oc_cntl_pln.sh"
  end

  # TripleO Undercloud, (deploycloud) vm details
  config.vm.define "ucsrv" do |ucsrv|
    ucsrv.vm.box = "centos7"
    ucsrv.vm.hostname = 'ucsrv.lab'
    ucsrv.vm.box_url = "file:///Users/ongomr/DevOps/tech/vagrant/boxes/centos7.box"
    ucsrv.vm.network :private_network, ip: "192.168.56.10"
    ucsrv.vm.network :private_network, ip: "172.168.0.10",
    virtualbox__intnet: "vlan_os_int"
    ucsrv.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
    ucsrv.vm.provider :virtualbox do |vucsrv|
      vucsrv.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vucsrv.customize ["modifyvm", :id, "--memory", 8192]
      vucsrv.customize ["modifyvm", :id, "--cpus", 2]
      vucsrv.customize ["modifyvm", :id, "--name", "ucsrv"]
    end
     # Setting up ssh keys for root
     config.vm.synced_folder "./configs/", "/mnt/configs"
     config.vm.provision "shell", path: "scripts/setup_ssh.sh"
     config.vm.provision "shell", path: "scripts/setup_locale.sh"
     config.vm.provision "shell", inline: "sudo yum update -y"
     config.vm.provision "shell", path: "scripts/setup_uc.sh"
  end

 ############################################################################################
#  Add PXE to cmpt01 and cntl01
#  Command below:
#  VBoxManage modifyvm pxe-server1 --boot4 net
#
#     sudo yum install -y https://trunk.rdoproject.org/centos7/current/python2-tripleo-repos-<version>.el7.centos.noarch.rpm
#     sudo -E tripleo-repos -b newton current
#     sudo -E tripleo-repos -b newton current ceph
#     export STABLE_RELEASE="newton"
#     export DIB_YUM_REPO_CONF="/etc/yum.repos.d/delorean*"
#     export DIB_YUM_REPO_CONF="$DIB_YUM_REPO_CONF /etc/yum.repos.d/CentOS-Ceph-Jewel.repo"
#     openstack overcloud image build
#     openstack overcloud image upload
#     openstack overcloud node import --introspect --provide instackenv.json
#     # other option to introspect
#     openstack workflow execution create tripleo.validations.v1.run_groups '{"group_names": ["pre-introspection"]}'
#     openstack overcloud node introspect --all-manageable
#     openstack overcloud node introspect --all-manageable --provide
#     openstack overcloud node provide --all-manageable
#     openstack subnet list
#     openstack subnet set <subnet-uuid> --dns-nameserver <nameserver-ip>
#     openstack workflow execution create tripleo.validations.v1.run_groups '{"group_names": ["pre-deployment"]}'
#     openstack overcloud deploy --templates [additional parameters]
#     openstack workflow execution create tripleo.validations.v1.run_groups '{"group_names": ["post-deployment"]}'
#     openstack network create public --external --provider-network-type flat \
#       --provider-physical-network datacentre
#     openstack subnet create --allocation-pool start=172.16.23.140,end=172.16.23.240 \
#       --network public --gateway 172.16.23.251 --no-dhcp --subnet-range \
#       172.16.23.128/25 public
#     openstack network create public --external --provider-network-type vlan \
#       --provider-physical-network datacentre --provider-segment 195 \
#    openstack subnet create --allocation-pool start=172.16.23.140,end=172.16.23.240 \
#       --network public --no-dhcp --gateway 172.16.23.251 \
#       --subnet-range 172.16.23.128/25 public
#    source ~/overcloudrc
#    mkdir ~/tempest
#    cd ~/tempest
#    /usr/share/openstack-tempest-*/tools/configure-tempest-directory
#    tools/config_tempest.py --deployer-input ~/tempest-deployer-input.conf \
#                         --debug --create \
#                         identity.uri $OS_AUTH_URL \
#                         identity.admin_password $OS_PASSWORD
#    tools/run-tests.sh
#
#   end
#
# https://www.rdoproject.org/tripleo/
# curl -O https://raw.githubusercontent.com/openstack/tripleo-quickstart/master/quickstart.sh
# sudo bash quickstart.sh --install-deps
#
#
# TripleO details
#   sudo yum install -y https://trunk.rdoproject.org/centos7/current/python2-tripleo-repos-0.0.1-0.20171116021457.15e17a8.el7.centos.noarch.rpm
#   sudo -E tripleo-repos -b newton current
#   sudo -E tripleo-repos -b newton current ceph

end
