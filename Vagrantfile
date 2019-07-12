# -*- mode: ruby -*-
# vi: set ft=ruby :

# Global variables for virtual box, this is to keep the resources used to a minimum
CPU = 1
RAM = 512
VM = 'ubuntu/bionic64'

# This is a default setting for vagrant to use a provider. '2' is the API version and should not be changed
Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.memory = RAM
    vb.cpus = CPU
  end
  #Share the root directory of where the vagrantfile is located into /shared on each guest
  config.vm.synced_folder ".", "/shared", type: "nfs"

  config.vm.define "load-balancer" do |lb|
    lb.vm.box = VM
    lb.vm.hostname = "lb.dev"
    lb.vm.network "private_network", ip: "172.0.0.5"
    lb.vm.network "forwarded_port", guest: 80, host: 8082
    lb.vm.provision "shell", inline: <<-SHELL
      sudo apt-get install python -y
      sudo cp /shared/.ssh/id_rsa.pub /home/vagrant/.ssh/authorized_keys
    SHELL
  end
  config.vm.define "nginx-one" do |none|
    none.vm.box = VM
    none.vm.hostname = "web-01.dev"
    none.vm.network "private_network", ip: "172.0.0.10"
    none.vm.network "forwarded_port", guest: 80, host: 8083
    none.ssh.forward_agent = true
    none.vm.provision "shell", inline: <<-SHELL
      sudo apt-get install python -y
      sudo cp /shared/.ssh/id_rsa.pub /home/vagrant/.ssh/authorized_keys
    SHELL
    # Here is the shell-provisioner one liner that checks to see if nginx 
    # is responding on port 80. 
    # none.vm.provision :shell do |shell|
    #     curl -s --head http://172.0.0.10:80 
    # end
  end
  config.vm.define "nginx-two" do |ntwo|
    ntwo.vm.box = VM
    ntwo.vm.hostname = "web-02.dev"
    ntwo.vm.network "private_network", ip: "172.0.0.20"
    ntwo.vm.network "forwarded_port", guest: 80, host: 8084
    ntwo.ssh.forward_agent = true
    ntwo.vm.provision "shell", inline: <<-SHELL
      sudo apt-get install python -y
      sudo cp /shared/.ssh/id_rsa.pub /home/vagrant/.ssh/authorized_keys
    SHELL
  end

  # This code block creates an ansible management box which is networked with its deployment targets. 
  # It is created last so it can manage the rest of the stack
  # ssh-keys are imported from the .ssh folder from the root of the project directory onto the guest 
  # and also itself, so that ansible can CM itself.
  config.vm.define "ansible-mgmt01" do |amgt01|
    amgt01.vm.box = VM
    amgt01.vm.hostname = "ansible-mgmt01"
    amgt01.vm.network "private_network", ip: "172.0.0.100"
    amgt01.ssh.forward_agent = true
    amgt01.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update -yq
      sudo apt-get install -y ansible
      sudo chown vagrant:vagrant /etc/ansible
      sudo cp /shared/ansible/ansible.cfg /etc/ansible/ansible.cfg
      cp /shared/.ssh/id_rsa /tmp/id_rsa
      sudo cp /shared/.ssh/id_rsa.pub /home/vagrant/.ssh/authorized_keys
      sudo chmod 600 /tmp/id_rsa
      # The below command creates an ansible hosts file 
      sudo echo -e "
      [loadbalancer]
      172.0.0.5
      [web]
      172.0.0.10
      172.0.0.20
      [management]
      172.0.0.100" > /etc/ansible/hosts
      sudo chown vagrant:vagrant /tmp/id_rsa
      ansible-playbook --private-key=/tmp/id_rsa -u vagrant /shared/ansible/install_nginx.yaml
      ansible-playbook --private-key=/tmp/id_rsa -u vagrant /shared/ansible/install_nginx_lb.yaml
      ansible-playbook --private-key=/tmp/id_rsa -u vagrant /shared/ansible/sudoers.yaml
    SHELL
  end
end


