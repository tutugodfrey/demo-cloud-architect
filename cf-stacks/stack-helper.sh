#! /bin/bash

# Create the VPC stack
aws cloudformation create-stack --stack-name cda-vpc-stack --template-body file://cf-stacks/vpc.yml

# Update the VPC stack
aws cloudformation update-stack --stack-name cda-vpc-stack --template-body file://cf-stacks/vpc.yml

# Create nat gateway stack
aws cloudformation create-stack --stack-name dca-nat-gateway-stack --template-body file://cf-stacks/nat-gateway.yml

# Update the nat gateway stack
aws cloudformation update-stack --stack-name dca-nat-gateway-stack --template-body file://cf-stacks/nat-gateway.yml

# Create Security group stack
aws cloudformation create-stack --stack-name dca-security-sg --template-body file://cf-stacks/security-groups.yml

# Update the Security Group Stack
aws cloudformation update-stack --stack-name dca-security-sg --template-body file://cf-stacks/security-groups.yml

# Create Postgres RDB Instance
# Ensure RDSDBPass is set in environment
# RDSDBPass=yourpasshere
aws cloudformation create-stack --stack-name rds-stack --template-body file://cf-stacks/rds-stack.yml --parameters ParameterKey=DBMasterPassword,ParameterValue=$RDSDBPass

# Update the Database Stack
aws cloudformation update-stack --stack-name rds-stack --template-body file://cf-stacks/rds-stack.yml --parameters ParameterKey=DBMasterPassword,ParameterValue=$RDSDBPass

# Create the read replica for the database
aws cloudformation create-stack --stack-name dca-rds-replica --template-body file://cf-stacks/rds-replica-stack.yml

#Update the read replica for the database
aws cloudformation update-stack --stack-name dca-rds-replica --template-body file://cf-stacks/rds-replica-stack.yml

# Use CLI to create a snapshot for the database
aws rds create-db-snapshot --db-snapshot-identifier dca-dev-snapshot --db-instance-identifier dca-dev-database

# Create the Load Balancer stack
aws cloudformation create-stack --stack-name dca-loadbalancer --template-body file://cf-stacks/load-balancer.yml

# Update the Load Balancer Stack
aws cloudformation update-stack --stack-name dca-loadbalancer --template-body file://cf-stacks/load-balancer.

# Create the app server stack
aws cloudformation create-stack --stack-name app-servers --template-body file://cf-stacks/app-servers.yml

# Update the app server stack
aws cloudformation update-stack --stack-name app-servers --template-body file://cf-stacks/app-servers.yml

# Create S3 stack
aws cloudformation create-stack --stack-name dca-s3-bucket --template-body file://cf-stacks/s3-bucket.yml

# Update S3 Stack
aws cloudformation update-stack --stack-name dca-s3-bucket --template-body file://cf-stacks/s3-bucket.yml

# Copy static files to S3 bucket;
# Replace $BUCKET_NAME or add to env
aws s3 cp index.html s3://$BUCKET_NAME
aws s3 cp error.html s3://$BUCKET_NAME

# Create the cloudfront distribution
aws cloudformation create-stack --stack-name cloudfront --template-body file://cf-stacks/cloudfront.yml

# Update the Cloudfront distribution
aws cloudformation update-stack --stack-name cloudfront --template-body file://cf-stacks/cloudfront.yml

# Create stack in order of depencencies.
# sleep command allows await time for dependent stacks to finish creating
function deploy_stacks() {
  aws cloudformation create-stack --stack-name cda-vpc-stack --template-body file://cf-stacks/vpc.yml;
}

# Deleting stacks
function delete_stacks() {
  aws cloudformation delete-stack --stack-name dca-loadbalancer # Delete the load balancer stack
  aws cloudformation delete-stack --stack-name dca-nat-gateway-stack # Nat gateway stack
  aws cloudformation delete-stack --stack-name cda-vpc-stack # VPC Stack
}
