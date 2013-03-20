# ansible-openshift_origin

Author: Adam Miller

#NOTE - THIS IS A WORK IN PROGRESS, THINK "ALPHA" QUALITY.

# About

This playbook helps install [OpenShift Origin](https://openshift.redhat.com/community/open-source) Platform As A Service.

Currently this playbook only supports installing on a single machine or 
(single-node install) which that the OpenShift Broker and OpenShift Node 
services are running on the same machine. This can be done on bare metal, in a 
virtual machine, or in a cloud instance as OpenShift only depends upon the 
Operating System (with SELinux, cgroups, and PAM magic under the hood).

# Requirements

* Fedora 18 - at least @standard if using a kickstart installation.
* Ansible >= 0.9

# Installation

The module can be obtained from the
[github repository](https://github.com/maxamillion/ansible-openshift_origin).

1. Download the [Zip file from github](https://github.com/maxamillion/ansible-openshift_origin/archive/master.zip)

(See "Configuration" and "Using" sections below for details)
2. For broker installs run 'ansible-playbook broker.yaml' ('brokers' is
a host group)
3. For node installs run 'ansible-playbook node.yaml' ('nodes' is a host 
group)


Reminder: This is currently only supporting a single-node install so 'brokers' 
and 'nodes' should both contain the same, single, ip address or hostname in the
inventory file.

# Configuration

You will either need to make entries in your /etc/ansible/hosts file for a 
[brokers] and a [nodes] section, or optionally create a hosts file and use the 
ansible -i option to point to your custom inventory file.

NOTE: This is currently only for single node deployments

Example:

    [brokers]
    192.168.1.100

    [nodes]
    192.168.1.100

# Using 

Once the configuration step is complete you can then run these configs with or
without a non-default inventory file.

Example with default inventory file (/etc/ansible/hosts):
    
    ansible-playbook broker.yml

    ansible-playbook node.yml

Example with non-default inventory file (/tmp/myhosts):
    
    ansible-playbook broker.yml -i /tmp/myhosts

    ansible-playbook node.yml -i /tmp/myhosts

# Web Console

Once the installation is complete, navigate to your machine (we'll assume here 
that the DNS pointer is broker.example.com) to https://broker.example.com/console
and the default username/password is admin/admin .... you SHOULD CHANGE THIS 
IMMEDIATELY if you plan to do anything of any amount of seriousness with your 
deployment.

