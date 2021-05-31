#! /bin/bash

# Create the VPC stack
aws cloudformation create-stack --stack-name cda-pvc-stack --template-body file://cf-stacks/vpc.yml

# Update the VPC stack
aws cloudformation update-stack --stack-name cda-pvc-stack --template-body file://cf-stacks/vpc.yml

# Deleting stacks
aws cloudformation delete-stack --stack-name cda-pvc-stack
