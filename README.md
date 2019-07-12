# Config Management Playground

This Repo is designed to be used as a tool to learn configuration management(CM). The structure is a skeleton which uses vagrant to spin up VM's inside VirtualBox with IP addresses, the idea being you use these VM's as targets - then install your choice of config management tool inside a CM management box, and from there administer payloads to the targets as you would do in a live environment. Do not use vagrant built-in config management tools, you will learn nothing.    

## Contents

1. Vagrantfile
2. Sample ansible folder.

### Getting Started
    Requirements: it is required that you have;
        1. VirtualBox installed
        2. Vagrant installed

1. Start with your objective in mind - i.e. spin up a highly available web stack and use the CM tool of choice to configure the web servers and deploy code to both web servers.
2. Configure the vagrantfile to configure a set of VM's, and use one of those VM's as the config management system to configure the rest of the VM's.
3. A sample vagrantfile and ansible setup are included in this repo. 
4. Ansible uses SSH to configure hosts. You will be required to configure your own SSH Keys on the targets. If you are unsure of how to do this look it up on google/youtube.

### Using Vagrant

When you have written a vagrantfile, use vagrant up in the command line in the same directory as your vagrant file and it will spin up your resources inside virtualbox, and execute the CM commands.

### Sample Objective

if you do not know what you want to achieve here is an example objective of a system you could potentially deploy;

    1. Create a Vagrantfile that creates a single machine using this box: https://app.vagrantup.com/ubuntu/boxes/bionic64 and installs the latest released version of your chosen configuration management tool.
    2. Install the nginx webserver via configuration management.
    3. Run a simple test using Vagrant's shell provisioner to ensure that nginx is listening on port 80
    4. Again, using configuration management, update contents of /etc/sudoers file so that Vagrant user can sudo without a password and that anyone in the admin group can sudo with a password.
    5. Make the solution idempotent so that re-running the provisioning step will not restart nginx unless changes have been made
    6. Create a simple "Hello World" web application in your favourite language of choice.
    7. Ensure your web application is available via the nginx instance.
    8. Extend the Vagrantfile to deploy this webapp to two additional vagrant machines and then configure the nginx to load balance between them.
    9. Test (in an automated fashion) that both app servers are working, and that the nginx is serving the content correctly.
    10. Have the webapp be dynamic - e.g. perform a db query for inclusion in the response (such as picking a random quote from a database) or calling an API of your choice(e.g. weather).
    11. Any additional resources (e.g. a shared db server) should be set up by the Vagrant file 
 
