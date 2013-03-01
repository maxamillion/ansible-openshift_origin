# ansible-openshift_origin

Author: Adam Miller

NOTE - THIS IS A WORK IN PROGRESS, DOES NOT WORK YET.

# About

This playbook helps install [OpenShift Origin](https://openshift.redhat.com/community/open-source) Platform As A Service.
Through the declaration of the `openshift_origin` class, you can configure the OpenShift Origin Broker, Node and support
services including ActiveMQ, Qpid, MongoDB, named and OS settings including firewall, startup services, and ntp.

# Requirements

* Ansible >= 0.9

# Installation

The module can be obtained from the
[github repository](https://github.com/maxamillion/ansible-openshift_origin).

1. Download the [Zip file from github](https://github.com/maxamillion/ansible-openshift_origin/archive/master.zip)
2. For broker installs run 'ansible-playbook brokers broker.yaml' ('brokers' is a host group)
3. For node installs run 'ansible-playbook nodes node.yaml' ('nodes' is a host group)

# Configuration
