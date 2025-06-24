# rsschool-devops-course-tasks
Terraform code aws_vpc/vpc.tf describes:

        VPC
        2 public subnets in different AZs
        2 private subnets in different AZs
        Internet Gateway
        Routing tables

Terraform code aws_vpc/ec2.tf describes:
        EC2 instances:
            Instances in all subnets can reach each other
            Instances in public subnets can reach addresses outside VPC and vice-versa

