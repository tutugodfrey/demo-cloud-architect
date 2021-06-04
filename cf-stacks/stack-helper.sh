#! /bin/bash

# Create the VPC stack
aws cloudformation create-stack --stack-name cda-pvc-stack --template-body file://cf-stacks/vpc.yml

# Update the VPC stack
aws cloudformation update-stack --stack-name cda-pvc-stack --template-body file://cf-stacks/vpc.yml

# Create nat gateway stack
aws cloudformation create-stack --stack-name dca-nat-gateway-stack --template-body file://cf-stacks/nat-gateway.yml

# Update the nat gateway stack
aws cloudformation update-stack --stack-name dca-nat-gateway-stack --template-body file://cf-stacks/nat-gateway.yml

# Create Security group stack
aws cloudformation create-stack --stack-name dca-security-sg --template-body file://cf-stacks/security-groups.yml

# Update the Security Group Stack
aws cloudformation update-stack --stack-name dca-security-sg --template-body file://cf-stacks/security-groups.yml

# Create the Load Balancer stack
aws cloudformation create-stack --stack-name dca-loadbalancer --template-body file://cf-stacks/load-balancer.yml

# Update the Load Balancer Stack
aws cloudformation update-stack --stack-name dca-loadbalancer --template-body file://cf-stacks/load-balancer.

# Create the app server stack
aws cloudformation create-stack --stack-name app-servers --template-body file://cf-stacks/app-servers.yml

# Deleting stacks
aws cloudformation delete-stack --stack-name cda-pvc-stack # VPC Stack
aws cloudformation delete-stack --stack-name dca-nat-gateway-stack # Nat gateway stack
aws cloudformation delete-stack --stack-name dca-loadbalancer # Delete the load balancer stack
