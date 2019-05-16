## AL Technical Test
    Note: This submission assumes the 'provider' for Vagrant will be VirtualBox,
          so virtualbox will be required on the host of this submission. 
          Furthermore, this solution was developed on a Windows 10 machine, and 
          files created on windows machines don't always automatically work on 
          linux. Whilst every attempt has been made to ensure this solution is 
          portable, some bugs may still occur. 

### Below are the steps to get you up and running immediately with my submission

    1. Go to the location you have unzipped the tar '../vgtest' in any terminal
    2. Run: vagrant up
    3. Go to your favourite browser and type localhost:8082, you will see a Hello World 
    written in html (and a button you can play with :))
    4. I have installed a mail server, on the ansible-mgmt01 box. If you knockout one of 
    the nginx boxes, I will receive an alert(if your laptop is connected to WiFi). Do so now using 'vagrant destroy nginx-one'
    5. To test it for yourself, you can ssh to the ansible mgmt box via 
    'ssh -i id_rsa -o StrictHostKeyChecking=no vagrant@172.0.0.100' and 
    edit /tmp/monitoring/monitoring.sh(using vim), and add your email to the list of 'EMAILS'. These can be comma seperated.
    The crontab is set to run every minute, but you can manually run the script if you do not wish to wait. Alternatively you can edit the script from /vgtest/monitoring/monitoring.sh and redeploy the stack.

### So what has been achieved?

    1. Create a vagrantfile that creates a single machine using ubuntu/bionic64 and install a CM tool
    2. Install nginx via CM (see ansible/install_nginx.yaml and the nginx-one.vm inside the vagrantfile)
    3. Run a simple test using vagrant shell provisioner (The test was a curl - it has been commented out because its now defunct but left in the vagrantfile as evidence )
    4. Update contents of sudoers using CM (see ansible/sudoers.yaml)
    5. Create a simple Hello World web app (see ansible/site)
    6. Ensure the web app is available via nginx (localhost:8082)
    7. Extend the vagrantfile to deploy 2 webservers and a load balancer, which serves traffic between the 2 web servers. (see /vgtest/ansible/default-lb)
    8. Test in an automated fashion that both app servers are working. (see /vgtest/monitoring folder)
 
### Whats in the folders?

There a list of folders included in the zip, these files all serve some purpose (except bootstrap, these were part of the first iteration of this solution and are now defunct, but are a talking point)

#### Ansible

This folder contains all of the config management files used to meet the solutions requirements. 
The website deployment subfolder is also located here.

#### Monitoring

This folder contains the monitoring scripts which are installed into crontab on ansible-mgmt01, and monitor the http of the web servers and load balancer.

## Appendix

Here is a list of IP addresses and useful copy/pastes to help you navigate this submission

Server IP's <br />
    Loadbalancer:   172.0.0.5 <br /> 
    nginx-one:      172.0.0.10 <br />
    nginx-two:      172.0.0.20 <br />
    ansible-mgmt01: 172.0.0.100 <br />

If you require `ssh` into any of the boxes use: 
    `ssh -i id_rsa -o StrictHostKeyChecking=no vagrant@<ip>`  <br />
id_rsa is located in /vgtest/.ssh/