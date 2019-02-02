#!/usr/bin/env bash

# Install Ansible
sudo apt-add-repository ppa:ansible/ansible

sudo apt-get update
sudo apt-get install ansible -y

# Setup Ansible for Local Use and Run
sudo mkdir /etc/ansible || true
cp /vagrant/ansible/inventories/dev /etc/ansible/hosts -f
#cp /vagrant/ansible/inventories/credentials.yml  /etc/ansible/
chmod 666 /etc/ansible/hosts
cat /vagrant/ansible/files/authorized_keys >> /home/ubuntu/.ssh/authorized_keys
#sed -i "s/#roles_path    = \/etc\/ansible\/roles/roles_path = \/vagrant\/roles/" /etc/ansible/ansible.cfg
#chmod 644 /vagrant/ansible.cfg
#ansible-galaxy install jdauphant.nginx
cd /vagrant/ && sudo ANSIBLE_CONFIG=/vagrant/ansible.cfg ansible-playbook playbooks/site.yml -i /etc/ansible/hosts -vvv -l $1 --connection=local -e "deploy_user=ubuntu"
