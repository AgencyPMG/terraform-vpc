# Terraform VPC Module

A terraform module that builds what we consider to be a good VPC.

## What's Included

- **Public Subnets** - Run your load balancer and such here. These talk to the
  outside world via an [internet gateway](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Internet_Gateway.html).
- **Private Subnets** - Run your application servers and self-managed backing
  services here (like databases). These talk to the outside world via an AWS
  [managed NAT](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-nat-gateway.html).
- **Internal Subnets** - Use this to setup [subnet groups](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Subnets)
  to run AWS managed services. These cannot talk to the outside world.
- **DNS** - An [Route 53](https://aws.amazon.com/route53/) zone associated with
  the VPC.
