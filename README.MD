This is a deploy of a web server in aws provider with terraform, with ansible and docker

With terraform we setup the infraestructure we want.

With the ansible playbook httpd_2048 (read ansible/ansible.cfg to see the pugins needed) 
we install docker, start it and enable it, 
then install docker-compose with pip3 
and finally copy the file compose.yaml inside the aws machine. 
 
Finally pull and up compose.yaml with the playbook dockercomup.yaml (module compose needs /usr/bin/python3 installed on the remote machine)  

To deploy this server u have to deploy it in Jenkins.
Requires ssh-agent plugin, pipeline-aws plugin, ansiColor plugin and timestamps plugin.

Also requires the credentials for aws and private keys for ssh (to connect to the machines)
