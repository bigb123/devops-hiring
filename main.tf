# This EKS terraform module script comes mostly from https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# I was about to use ready VPC Terraform script https://gist.github.com/PrashantBhatasana/39d6e9e4bd9e50304e3da4fb752faf6f#file-main-tf
# but decided to rather avoid spending time on tweaking all this generic stuff related to public/private
# subnets (NAT gateway, internet gateway etc.) to focus on the kube configuration
# itself.

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"

  cluster_version = "1.21"
  cluster_name    = "django-app-cluster"
  vpc_id          = aws_vpc.main.id
  subnets         = [aws_subnet.private.id]

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size  = 5
    }
  ]
}

# I also skipped creation of ECR and RDS 