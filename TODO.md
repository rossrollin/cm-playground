# TODO

### Sacrifices

This is my first time using Vagrant and Ansible, so some shortcuts have been taken and some Design Patterns were flagrantly disregarded. 
All of course in the name of rapidly producing a solution. However given more time, experience and resources there are a few things I would like to accomplish

    1. I would clean up the vagrantfile to use the 1..2.do each method and not repeat code, and also assign IP's as variables 
    and increment them on deployment rather than having everything hard-coded as it is currently. As it is however its easy to read and you can see what is going on.

    2. The monitoring is very basic, it satisfies the criteria of automated testing but there are 
    far better ways of doing so using solutions designed for such. Since there is mailing already configured it wouldnt be a stretch to add NagiOS and deploy some agents. 

    3. Extend the vagrantfile to add a shared DB and a playbook to configure as such, which would serve up content as requested,
     rather than a hard coded javascript array which returns a quote when you click a button.

    4. Unfortunately I do not know enough about ansible to edit the configurations to make them only update the Nginx configs 
    once changes have been detected. The configure nginx yaml file restarts nginx every time it is run. With more understanding 
    I would implement proper handlers for the playbooks.

