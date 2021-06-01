#! /bin/bash

# Create the VPC stack
aws cloudformation create-stack --stack-name cda-pvc-stack --template-body file://cf-stacks/vpc.yml

# Update the VPC stack
aws cloudformation update-stack --stack-name cda-pvc-stack --template-body file://cf-stacks/vpc.yml

# Create nat gateway stack
aws cloudformation create-stack --stack-name dca-nat-gateway-stack --template-body file://cf-stacks/nat-gateway.yml

# Update the nat gateway stack
aws cloudformation update-stack --stack-name dca-nat-gateway-stack --template-body file://cf-stacks/nat-gateway.yml

# Deleting stacks
aws cloudformation delete-stack --stack-name cda-pvc-stack # VPC Stack
aws cloudformation delete-stack --stack-name dca-nat-gateway-stack # Nat gateway stack
