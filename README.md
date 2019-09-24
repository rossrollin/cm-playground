# Config Management Playground

This Repo is designed to be used as a tool to learn configuration management(CM). The structure is a skeleton which uses vagrant to spin up VM's inside VirtualBox with IP addresses, the idea being you use these VM's as targets - then install your choice of config management tool inside a CM management box, and from there administer payloads to the targets as you would do in a live environment. Do not use vagrant built-in config management tools, you will learn nothing.    

This sample repository uses Vagrant and Ansible.

## Contents

1. Vagrantfile
2. Sample ansible folder with roles, handlers and standard playbooks.

### Getting Started
    Requirements: it is required that you have;
        1. VirtualBox installed
        2. Vagrant installed

1. Start with your objective in mind - i.e. spin up a highly available web stack and use the CM tool of choice to configure the web servers and deploy code to both web servers.
2. Configure the vagrantfile to configure a set of VM's, and use one of those VM's as the config management system to configure the rest of the VM's.
3. A sample vagrantfile and ansible setup are included in this repo. 
4. Ansible uses SSH to configure hosts. You will be required to configure your own SSH Keys on the targets. If you are unsure of how to do this look it up on google/youtube.

### Using Vagrant

Included in this sample repository is a vagrantfile which configures an environment in VirtualBox for you containing 4 VM's, 1 VM with NGINX configured as a load balancer, 2 VM's with NGINX configured as web servers, and a 4th VM which is used as to host Ansible.

To get started, go to the root directory and use the following command:
```
vagrant up
```

Note: When you have written a vagrantfile, use vagrant up in the command line in the same directory as your vagrantfile and it will execute the commands written in the vagrantfile. 

### Sample Objective

if you do not know what you want to achieve here is an example objective of a system you could potentially deploy(some of this is already configured in this repository);

    1. Create a Vagrantfile that creates a single machine using this box: https://app.vagrantup.com/ubuntu/boxes/bionic64 and installs the latest released version of your chosen configuration management tool.
    2. Install the nginx webserver via configuration management.
    3. Run a simple test using Vagrant's shell provisioner to ensure that nginx is listening on port 80
    4. Again, using configuration management, update contents of /etc/sudoers file so that Vagrant user can sudo without a password and that anyone in the admin group can sudo with a password.
    5. Make the solution idempotent so that re-running the provisioning step will not restart nginx unless changes have been made (using handlers)
    6. Create a simple "Hello World" web application in your favourite language of choice.
    7. Ensure your web application is available via the nginx instance.
    8. Extend the Vagrantfile to deploy this webapp to two additional vagrant machines and then configure the nginx to load balance between them.
    9. Test (in an automated fashion) that both app servers are working, and that the nginx is serving the content correctly.
    10. Have the webapp be dynamic - e.g. perform a db query for inclusion in the response (such as picking a random quote from a database) or calling an API of your choice(e.g. weather).
    11. Any additional resources (e.g. a shared db server) should be set up by the Vagrant file 
 
## Conventions

The layout of the ansible directories follows (loosely) the ansible recommended implementation for ansible roles, see below:

### Content Organization

The following section shows one of many possible ways to organize playbook content.

Your usage of Ansible should fit your needs, however, not ours, so feel free to modify this approach and organize as you see fit.

One crucial way to organize your playbook content is Ansible’s “roles” organization feature, which is documented as part of the main playbooks page. You should take the time to read and understand the roles documentation which is available here: Roles.
Directory Layout

The top level of the directory would contain files and directories like so:
```
production                # inventory file for production servers
staging                   # inventory file for staging environment

group_vars/
   group1.yml             # here we assign variables to particular groups
   group2.yml
host_vars/
   hostname1.yml          # here we assign variables to particular systems
   hostname2.yml

library/                  # if any custom modules, put them here (optional)
module_utils/             # if any custom module_utils to support modules, put them here (optional)
filter_plugins/           # if any custom filter plugins, put them here (optional)

site.yml                  # master playbook
webservers.yml            # playbook for webserver tier
dbservers.yml             # playbook for dbserver tier

roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""
```
