# ansible-openshift_origin

Author: Adam Miller

#NOTE - THIS IS A WORK IN PROGRESS, THINK "BETA" QUALITY.
This playbook is currently undergoing a refactor for the ansible 1.2 newly 
introduced "roles" layout for playbooks. If you'd like to find the old version
then feel free to checkout the branch named v0.9.

I've bumped this from "Alpha" to "Beta" quality because I've done a full deploy
using the playbook but there are still a couple rough edges I want to clean up
as well as refactor some tasks to be "cleaner".

# About

This playbook helps install [OpenShift Origin](https://www.openshift.com/open-source) Platform As A Service.

Currently this playbook only supports installing on a single machine or 
(single-node install) which that the OpenShift Broker and OpenShift Node 
services are running on the same machine. This can be done on bare metal, in a 
virtual machine, or in a cloud instance as OpenShift only depends upon the 
Operating System (with SELinux, cgroups, and PAM magic under the hood).


The playbook is based on the [OpenShift Origin Comprehensive Deployment Guide](http://openshift.github.io/documentation/oo_deployment_guide_comprehensive.html)

# Requirements

Install Target:
* Fedora 19 - at least @standard if using a kickstart installation.

Machine Deploying From (The Orchestration Machine)
* Ansible >= 1.2

# Installation

The module can be obtained from the
[github repository](https://github.com/maxamillion/ansible-openshift_origin).

1. Download the [Zip file from github](https://github.com/maxamillion/ansible-openshift_origin/archive/master.zip)

(See "Configuration" and "Using" sections below for details) 

Reminder: This is currently only supporting a single-node install so 'brokers' 
and 'nodes' should both contain the same, single, ip address or hostname in the
inventory file.

# Configuration

## Ansible
You will either need to make entries in your /etc/ansible/hosts file for a 
[brokers], [nodes], and [support_nodes] sections, or optionally create a 
hosts file and use the ansible -i option to point to your custom inventory 
file. (The inventory.txt in this git repo is such a file)

NOTE: This is currently only for single node deployments

Example:

    [brokers]
    192.168.1.100

    [nodes]
    192.168.1.100

    [support_nodes]
    192.168.1.100


# Using 

Once the configuration step is complete you can then run these configs with or
without a non-default inventory file.

Example with default inventory file (/etc/ansible/hosts):
    
    ansible-playbook site.yml

Example with non-default inventory file (inventory.txt):
    
    ansible-playbook site.yml -i inventory.txt

Example running only against nodes (note: this is a tag from the site.yml):

    ansible-playbook site.yml -i inventory.txt -t nodes 

If you would like to use the Fedora 19 cloud images provided 
[here](https://fedoraproject.org/en/get-fedora-options#clouds) then you should
use sudo with the default fedora user provided with these images:

    ansible-playbook site.yml -s -u fedora -i inventory.txt
    


# Web Console

Once the installation is complete, navigate to your machine (we'll assume here 
that the DNS pointer is broker.example.com) to https://broker.example.com/console
and the default username/password is admin/admin .... you SHOULD CHANGE THIS 
IMMEDIATELY if you plan to do anything of any amount of seriousness with your 
deployment.

# rhc - OpenShift command line util
If you are going to use the rhc client you will need to create a config,
there is a config example called express.conf.example in the docs dir of this
repo

You can also use the rhc wizard by pointing it to your broker node.

The password for the command line utility will be the same as the web console.

Example:

    ## NOTE: Need the -k because we're using a self signed cert in our example.
    rhc -k setup --server=192.168.1.100


# Notes

Just some fun little "gotchyas" that are being worked through, but in the mean
time warrant some amount of mention. This section will be updated as necessary.

0. This is a pet project that I've been fortunate enough to carve off a little 
time to work on during my $dayjob because my job, boss, and company are awesome.
As with any pet project, it might get stale but I will do my best to keep it 
up to date as well as expand on it as time goes on to handle more sophisticated
configrations and deployments.

1. All shell commands run (currently firewall-cmd is a big one) return "changed"
  in the playbook summary but once Ansible 1.3 releases stable this will change as
  we can set conditions for command execution to have considered a change

2. Upstream Fedora ActiveMQ is broken so the option to use QPID is in the 
  group vars file "all" but the ActiveMQ package in the OpenShift Origin deps
  repo is fixed. There's a trello card open on our public board to get all the
  deps into Fedora proper as well as fix those that are already there: 
  
  https://trello.com/c/v3SYHVHF/27-get-all-openshift-origin-dependencies-packaged-and-into-fedora

3. There's an issue with FirewallD on a fresh launch of a Fedora AMI cloud image
  where sometimes it will just timeout talking to dbus and the operation will
  hang. This needs further investigation when I can find time.

4. For some reason the first time you set the kernel semaphors with sysctl the 
  ansible playbook hangs but on every rerun it's fine.

5. The openshift-tc service which deals with transport control and traffic 
  throttling, will often fail to start on a fresh reboot due to some finer
  points of systemd. Details here: http://www.freedesktop.org/wiki/Software/systemd/NetworkTarget
  Also note, this is a known issue and the OpenShift Origin developers are 
  working on resolving this.

A workaround is:

    ansible nodes -m shell -a 'service openshift-tc stop && service openshift-tc start' -i inventory.txt

And if you chose to use sudo with the user "fedora":

    ansible nodes -m shell -a 'service openshift-tc stop && service openshift-tc start' -i inventory.txt -u fedora -s

# Contact Info

If you'd like, just open an issue against this on github and I'll get to is asap.

If you'd like to try for more immediate feedback, feel free to ping me on irc. I
only frequent freenode and am in more channels than is healthy, but below are 
the ones I spend the most time in and/or paying attention to:
- IRC Nick: maxamillion
- IRC Channels: #openshift-dev #openshift #ansible #fedora #fedora-devel #rhel 
- IRC Network: irc.freenode.net
