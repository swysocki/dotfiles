# Bootstrap Playbook

Sets up Bash on a Linux host.  Tested on Ubuntu 20.04.  No need 
to clone this repo, just curl the playbook and the rest is taken care of.

## Install

Make sure Ansible is installed :| You will also need a module from Galaxy:
```
$ ansible-galaxy collection install ansible.posix community.general
```
Grab this file directly:
```
$ curl https://raw.githubusercontent.com/swysocki/dotfiles/master/ansible/playbook.yml -O
```
## Run

```
$ ansible-playbook ./playbook.yml
```
