resource "aws_eks_cluster" "eks" {
  name        = var.eks_cluster_name
  role_arn    = aws_iam_role.eks_cluster.arn
  version     = "1.24"

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids              = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly_EKS
  ]

  tags = var.tags
}

resource "aws_iam_role" "eks_cluster" {
  name               = "eks-cluster1"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly_EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_policy" "eks_cluster_policy" {
  name        = "eks-cluster-policy"
  description = "Policy for EKS cluster"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:CreateCluster",
        "eks:DescribeCluster",
        "eks:ListNodegroups",
        "eks:CreateNodegroup",
        "eks:DescribeNodegroup",
        "eks:TagResource"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": "arn:aws:iam::185869047570:role/eks-cluster1"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = aws_iam_policy.eks_cluster_policy.arn
  roles      = [aws_iam_role.eks_cluster.name]
}

