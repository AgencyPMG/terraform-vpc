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

#### Note on Private Subnets

It's generally a good idea to have one NAT server per availability zone. So when
you opt in to private subnets, this module will create corresponding public
subnets -- one per private subnet AZ -- in which it will place NAT servers.

## Usage

```hcl
module "vpc" {
    source = "github.com/AgencyPMG/terraform-vpc"
    app = "appname"
    env = "prod" // or ${terraform.env}
    cidr = "10.50.0.0/16" // default is 10.0.0.0/16
    public_subnet_azs = ["us-east-1a", "us-east-1e"]
    private_subnet_azs = ["us-east-1a", "us-east-1e"]
    internal_subnet_azs = ["us-east-1a", "us-east-1e"]
    dns_name = "appname.internal"
}
```

### Disabling Classes of Subnets

Say you don't need private subnets: just pass in an empty list.

```hcl
module "vpc" {
    source = "github.com/AgencyPMG/terraform-vpc"
    // ...
    private_subnet_azs = [] // do this for any *_subnet_azs
}
```
