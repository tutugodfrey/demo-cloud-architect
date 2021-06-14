# demo-cloud-architect
Build a robust cloud architectural solution on AWS

## Infrastructure provisioning
Assuming your are in the project root directory, run the following commands to provision the infrastructure

Create the VPC

```bash
aws cloudformation create-stack --stack-name cda-vpc-stack --template-body file://cf-stacks/vpc.yml
```

# Updating the infrastructure

Assuming you are in the project root directory run any of the following command to update components of the infrastructure as needed

```bash
aws cloudformation update-stack --stack-name cda-vpc-stack --template-body file://cf-stacks/vpc.yml
```




## Cleaning up the infrastructure

Assuming you are in the project root directory run the following commands to clean what has been provisioned

```bash
aws cloudformation delete-stack --stack-name cda-vpc-stack
```