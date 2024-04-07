# Technical Assessment Report

## Introduction

This report outlines the approach taken to complete the technical assessment tasks, including provisioning an EC2 instance using Terraform, configuring Nginx web server using Ansible, and using Ansible to deploy WordPress using Docker.

## Task 1: Terraform

The first task involved creating a Terraform project to provision an EC2 instance on AWS. The following steps were taken:

1. I started by creating an Access Key for the account supplied, and configured my aws cli to verify that the access is working.
2. I then created a Terraform configuration file (`main.tf`) to define the AWS provider, EIP, VPC, subnet, security group, and EC2 instance resources.
3. Used variables in the Terraform configuration files to make the code more reusable and maintainable.
4. Added userdata to the instance to ensure python is installed for ansible (Done at a later stage)
5. I also used a tag in the creation of all the resources to easily find all the resources created for this assessment. (`assessment_Hannes : true`)

Challenges faced:

- The usual back and forth with troubleshooting each time there was an error or odd mis-configuration, nothing noteworthy to mention.

## Task 2: Ansible

The second task involved using Ansible to install and configure a Nginx web server on the provisioned EC2 instance. The following steps were taken:

1. I Created an Ansible inventory file to specify the EC2 instance's public IP address and SSH connection details.
2. I wrote an Ansible playbook (`nginx.yml`) to install Nginx and start the Nginx service.
3. I wrote another playbook (`vhost.yml`) to remove the default site then configure and enable a virtual host.
4. I created a small temp index.html file to be copied over as one of the steps as well - this ensures I am able to confirm the change has gone in.
5. Created a Jinja2 template file (`vhost.conf.j2`) to define the virtual host configuration.
6. Then executed the Ansible playbooks using `ansible-playbook -i inventory.ini nginx.yml` and `ansible-playbook -i inventory.ini vhost.yml` to configure Nginx on the EC2 instance.
7. I verified the successful installation and configuration of Nginx by accessing the EC2 instance's public IP address in a web browser.

Challenges faced:

- I had issues getting Ansible to connect to the instance at first, and found that the instance needed python3 installed, so I created userdata to install it with the instance creation using terraform, marked the instance as tainted and got it re-created.
- Other than that nothing else noteworthy to mention.

## Bonus Task: Deploy WordPress using Docker

As a bonus task, WordPress was deployed on the EC2 instance using Docker. The following steps were taken:

1. I created an Ansible playbook (`wordpress.yml`) to install Docker with all the required steps to get a Docker Wordpress site on the EC2 instance.
2. I configured the Wordpress container to map port 8080 on the Docker host to TCP port 80 in the container, and had to add port 8080 on the Security Group in the Terraform code, I then applied it and the port was open.
3. Executed the Ansible playbook using `ansible-playbook -i inventory wordpress.yml` to deploy WordPress on the EC2 instance.

Challenges faced:

- Port 80 was already in use on the host, had to map to another port.
- Ensuring the correct file paths and permissions for the WordPress content and database data.

## Conclusion

Through this technical assessment, I successfully provisioned an EC2 instance using Terraform, configured Nginx web server using Ansible, and deployed WordPress using Docker. The tasks involved working with infrastructure as code, configuration management, and containerization technologies.

The challenges faced during the assessment included ensuring correct configurations, file paths, and permissions, as well as handling service restarts and linking containers. These challenges were overcome through careful review of documentation, troubleshooting, and iterative testing.

Overall, the assessment provided an opportunity to demonstrate skills in automating infrastructure provisioning, configuring web servers, and deploying applications using industry-standard tools and practices.

## Further Considerations and Best Practices

While the assessment tasks covered the basic setup and deployment, there are several best practices and considerations to keep in mind for a production-ready environment:

1. **HTTPS Configuration**: It is essential to secure the website with HTTPS to encrypt the communication between the client and the server. This involves obtaining an SSL/TLS certificate from a trusted certificate authority and configuring Nginx to use the certificate for HTTPS traffic.

2. **Security Hardening**: Implement security best practices such as keeping the operating system and software packages up to date, configuring strict firewall rules, enabling SSH key-based authentication, and disabling root login.

3. **Backup and Disaster Recovery**: Set up regular backups of the WordPress content and database to ensure data integrity and facilitate quick recovery in case of any failures or disasters. Consider using AWS services like Amazon EBS snapshots or Amazon S3 for backup storage.

4. **Monitoring and Logging**: Implement monitoring and logging solutions to track the health and performance of the EC2 instance, Nginx web server, and WordPress application. Tools like AWS CloudWatch, Nagios, or ELK stack can be used for this purpose.

5. **Scalability and High Availability**: As the website grows, consider implementing scalability and high availability measures. This may involve using AWS Auto Scaling to automatically adjust the number of EC2 instances based on traffic, load balancing with AWS Elastic Load Balancer (ELB), and configuring a multi-AZ setup for database redundancy.

6. **Caching and Performance Optimization**: Implement caching mechanisms like Nginx caching or WordPress caching plugins to improve the website's performance and reduce the load on the server. Optimize images, minify CSS and JavaScript files, and leverage content delivery networks (CDNs) for faster content delivery.

7. **Security Plugins and Updates**: Install and configure security plugins for WordPress, such as Wordfence or Sucuri, to protect against common web vulnerabilities like SQL injection and cross-site scripting (XSS). Regularly update WordPress core, themes, and plugins to ensure the latest security patches are applied.

8. **Automated Deployment and Continuous Integration**: Implement an automated deployment pipeline using tools like Jenkins, GitLab CI/CD, or AWS CodePipeline to streamline the deployment process and ensure consistent and reliable deployments. Integrate continuous integration practices to automatically build, test, and deploy code changes.

9. **Access Control and User Management**: Configure proper access control and user management within WordPress. Limit administrative access to trusted individuals, use strong passwords, and implement two-factor authentication (2FA) for enhanced security.

10. **Regular Testing and Auditing**: Perform regular security testing and auditing of the infrastructure and application to identify and address any vulnerabilities or misconfigurations. Conduct penetration testing, vulnerability scanning, and code reviews to ensure the system remains secure.

These considerations and best practices are not exhaustive but provide a starting point for further enhancements and optimizations to ensure a secure, scalable, and well-maintained environment.
